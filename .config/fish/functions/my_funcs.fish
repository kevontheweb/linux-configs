function md2ps
    set base (basename $argv[1] .md)
    pandoc -t ms -s $argv[1] | groff -ms -e -p -t > $base.ps
    xdg-open $base.ps
end

function md2pdf
    set base (basename $argv[1] .md)
    pandoc -t ms -s $argv[1] | groff -ms -e -p -t > /tmp/out.ps
    ps2pdf /tmp/out.ps $base.pdf
    xdg-open $base.pdf
    rm /tmp/out.ps
end
