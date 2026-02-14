#!/usr/bin/env fish

fuzzel -dl 0 </dev/null | read -l input
test "$input" || return 1
set -l file "$argv[1]/$input"
switch (path extension -- $input)
    case .fish
        echo -e "#!/usr/bin/env fish\n\n" >$file
    case .nu
        echo -e "#!/usr/bin/env -S nu --no-std-lib -n\n\n" >$file
    case .dash .sh '*'
        echo -e "#!/usr/bin/env dash\n\n" >$file
end
chmod +x $file
echo -n $file:3
