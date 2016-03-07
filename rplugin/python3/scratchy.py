#!/usr/bin/env python
# -*- coding: utf-8 -*-
import neovim
import subprocess
import os
import logging
import glob, re, tempfile

@neovim.plugin
class Scratchy(object):
    scratchers = {}

    def __init__(self, vim):
        self.vim = vim
        self.calls = 0
        self.codebuff = None
        self.databuff = None
        self.outbuff = None
        self.tf = None

    def log(self, str):
        self.vim.command("echom '%s'"% str)

    @neovim.command('Scratchy', range='', nargs='*', sync=True)
    def command_handler(self, args, range):
        ft = self.vim.eval('&ft')
        self.log("setup")
        if len(args) == 0 and ft == 'json':
            self.log("setup single file")
            self.setup()
        elif len(args) >= 1:
            if bool(re.match('^!.*', args[0])):
                print(args)
                self.cmd_files(args)
            else:
                self.multi_files(args)
            self.vim.command("setlocal bh=wipe noma nomod nonu nowrap ro nornu")
            self.setup()

    def cmd_files(self, args):
        self.log(args[0])

    # assumes args >= 1
    def multi_files(self, args):
        self.log("begin multi file setup")
        paths = []
        self.tf = tempfile.NamedTemporaryFile(mode='wb', delete=False)
        for ar in args:
            for fn in glob.iglob(os.path.expanduser(ar), recursive=True):
                self.log(fn)
                with open(fn, mode='rb') as infile:
                    for line in infile:
                        self.tf.write(line)
                paths.append(fn)
        self.tf.close()
        self.vim.command('edit %s'% self.tf.name)
        self.databuff = self.vim.current.buffer
        self.databuff.name = "[Data]"
        self.log("end multi file setup")

    def setup(self):
        self.databuff = self.vim.current.buffer
        #########################
        self.vim.command('tabnew')
        # setup output
        self.outbuff = self.vim.current.buffer
        self.outbuff.name = "[Output]"
        self.vim.command("set syntax=json")
        self._readonly(self.outbuff)
        self.vim.command("setlocal bt=nofile bh=wipe noma nomod nonu nobl nowrap ro nornu")
        #########################
        self.vim.command('vnew')
        # setup input
        self.codebuff = self.vim.current.buffer
        self.codebuff.options["buftype"]="nofile"
        self.vim.command("set syntax=jq")
        self.codebuff.name = "[jq]"
        self.vim.command('b %s'% self.databuff.number) 
        #########################
        self.vim.command('split')
        self.vim.command('wincmd K')
        # add data source
        self.vim.current.window.height = 10
        self.vim.command('b %s'% self.codebuff.number)
        self.addcmds(self.codebuff.number)
        self.vim.current.line = ".[]|.url"
        self.run()

    def addcmds(self, buffnum):
        self.buffaucmd('TextChangedI', buffnum, 'ScratchyRun')
        self.buffaucmd('TextChanged', buffnum, 'ScratchyRun')

    def buffaucmd(self, aucmd, buffnum, cmd):
        self.vim.command('au %s <buffer=%s> %s'% (aucmd, buffnum, cmd))

    def setoutput(self, content, split=True, delim='\n'):
        self._readonly(self.outbuff, False)
        if split:
            self.outbuff[:] = content.split(delim)
        else:
            self.outbuff.append(content)
        self._readonly(self.outbuff, True)

    def _readonly(self, buff, readOnly=True):
        buff.options["modifiable"] = not readOnly
        buff.options["modified"] = not readOnly
        buff.options["readonly"] = readOnly
        #buf = self.vim.current.buffer

    @neovim.command('ScratchyRun', range='', nargs='*', sync=True)
    def run(self, args=[], range=0):
        cmds = " ".join(self.codebuff[:])
        try:
            self.log("data buff: %s"%self.databuff.name)
            if self.tf is not None:
                self.log("using temp file")
                content = subprocess.check_output(
                    ['jq', '-M', cmds, self.tf.name])
            else:
                self.log("using buffer file")
                content = subprocess.check_output(
                    ['jq', '-M', cmds, self.databuff.name])
            content = content.decode('utf-8')
            self.setoutput(content) 
            self.log("success")
        except Exception as excep:
            self.log("processed filter unfinshed")

    #\xe2☠
    # def _syntax(self, buff, syn):
    #     if syn == "sh":
    #         self.vim.command("let g:is_bash = 1")
    #         buff.name = "[Bash]"
    #     else:
    #         buff.name = "[%s]"% syn
    #         self.vim.command('au! TextChangedI \[abcd\] :call Scratchy_run()')
    #     buff.options["buftype"]="nofile"
    #     self.vim.command("set syntax=%s"% syn)

