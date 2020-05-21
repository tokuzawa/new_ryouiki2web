#add url for r2 web
Encoding.default_external = 'utf-8'
fns = []
outdir = 'docs/'
urla = 'http://www.r2.div.jps.or.jp/'

Dir.glob('*.md'){|fn|
    # print fn, "\n"
    fns.push(fn)
}

=begin
n = 0
fns.each{|fn|
    print n, ':', fn, "\n"
    n += 1
}
=end

#str = "[aaa](bbb) [ccc](ddd)"
#print str, "\n"
#print str.gsub(/\((.*?)\)/){|m| '(http'+$1+')'}

fns.each{|fn|
    # print fn, "  "
    otitle = fn.gsub(/\.md/){|m| '.html'}
    ofn = outdir+fn.gsub(/\.md/){|m| '.html'}
    # print ofn, "\n"
    str2 = ""
    File.open(fn).each_line{|line|
        if /\[.*\]\((.*?)\)/ =~ line
            url = $1
            if /http.*/ !~ url
                line = line.gsub!(/\((.*?)\)/){|m| '(' + urla+$1+')'}
            end
        end
        if /src *= *\"(.*?)\"/ =~ line    
            url = $1
            if /http.*/ !~ url
                line = line.gsub!(/src *= *\"(.*?)\"/){|m| 'src="' + urla+$1+'"'}
            end
        end 
        if /href *= *\"(.*?)\"/ =~ line    
            url = $1
            if /http.*/ !~ url
                line = line.gsub!(/href *= *\"(.*?)\"/){|m| 'href="' + url+$1+'"'}
            end 
        end 
        str2 += line
    }

    f=File.open('temp.md', 'w')
    f.puts(str2)
    f.close()

    if otitle == "main.html"
        otitle = "index.html"
        ofn = outdir + otitle
    end 
    cmd = "pandoc --template=template.html --metadata pagetitle=\"#{otitle}\" temp.md -o #{ofn}"
    print cmd, "\n"
    system(cmd)
}

