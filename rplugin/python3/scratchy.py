#!/usr/bin/env python
# -*- coding: utf-8 -*-
import neovim
import subprocess
#from jq import jq
import logging

@neovim.plugin
class Scratchy(object):
    scratchers = {}

    def __init__(self, vim):
        self.vim = vim
        self.calls = 0
        self.codebuff = None
        self.databuff = None
        self.outbuff = None

    def log(self, str):
        self.vim.command("echom '%s'"% str)

    @neovim.command('Scratchy', range='', nargs='*', sync=True)
    def command_handler(self, args, range):
        ft = self.vim.eval('&ft')
        self.log("args %s, range %s, ft %s"%(args, range, ft))
        if len(args) == 0 and ft == 'json':
            self.log("run setup")
            self.setup()
        # elif range == 1:
        #     self.vim.eval(args[0])
        #     self.useinput(self.vim.current.buffer)

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

    def _modout(self, buff, content, split=True, delim='\n'):
        self._readonly(buff, False)
        if split:
            self.outbuff[:] = content.split(delim)
        else:
            self.outbuff.append(content)
        self._readonly(buff, True)

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

    def _readonly(self, buff, readOnly=True):
        buff.options["modifiable"] = not readOnly
        buff.options["modified"] = not readOnly
        buff.options["readonly"] = readOnly
        #buf = self.vim.current.buffer

    #def run(self, args=[]):
    @neovim.command('ScratchyRun', range='', nargs='*', sync=True)
    def run(self, args=[], range=0):
        cmds = " ".join(self.codebuff[:])
        try:
            self.log("data buff: %s"%self.databuff.name)
            content = subprocess.check_output(
                    ['jq', '-M', cmds, self.databuff.name])
            content = content.decode('utf-8')
            self._modout(self.outbuff, content) 
            self.log("success")
        except Exception as excep:
            self.log("processed filter unfinshed")

    # @neovim.function('Func')
    # def function_handler(self, args):
    #     self.log("helloo")
        # self._increment_calls()
        # self.vim.current.line = (
        #         'Function: Called %d times, args: %s' % (self.calls, args))
        #     raise Exception('Too many calls!')
        #self.calls += 1
