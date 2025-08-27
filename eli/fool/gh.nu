#!/usr/bin/env -S nu -n --no-std-lib

# function gh
#     if test "$argv[1]" = repo
#         switch "$argv[2]"
#             case fork
#                 command gh repo fork --clone --default-branch-only $argv[3..]
#                 z (path basename $argv[3])
#                 return
#             case clone
#                 command gh repo clone $argv[3..]
#                 z (path basename $argv[3])
#                 return
#             case create
#                 command gh repo create --clone -l MIT $argv[3..]
#                 z $argv[-1]
#                 return
#         end
#     end
#     command gh $argv
# end

def --wrapped main [...rest] {
	^gh ...$rest
}

def --wrapped 'main repo create' [name: string, ...rest] {
	^gh repo create --clone -l MIT $name ...$rest
}
