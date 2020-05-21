#add url for r2 web
Encoding.default_external = 'utf-8'
fns = []
Dir.glob('*.md'){|fn|
    # print fn, "\n"
    fns.push(fn)
}

print fns[4]
File.open(fns[4]).each_line{|line|
    if /\[.*\]\((.*)\)/ =~ line
        print $1, "\n"
    end
}