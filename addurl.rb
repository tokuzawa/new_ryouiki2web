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
str2 = ""
File.open('template.html').each_line{|line|
    if /href *= *\".*index.html\"/ =~ line    
        url = $1
        line = line.gsub!(/index/){|m| 'main'}
    end 
    str2 += line
} 
f = File.open('template2.html', 'w')
f.puts(str2)
f.close

#str = "[aaa](bbb) [ccc](ddd)"
#print str, "\n"
#print str.gsub(/\((.*?)\)/){|m| '(http'+$1+')'}
#fns = ['main.md']
fns.each{|fn|
    # print fn, "  "
    otitle = fn.gsub(/\.md/){|m| '.html'}
    ofn = outdir+fn.gsub(/\.md/){|m| '.html'}
    # print ofn, "\n"
    str2 = ""
    File.open(fn).each_line{|line|
        if /\[.*?\]\((.*?)\)/ =~ line
            url = $1
            if /http.*/ !~ url && /.*\/.*/ =~ url && /href/!~ line && /src/ !~line
                line.gsub!(/\[(.*?)\]\((.*?)\)/){|m| '['+$1+'](' + urla+$2+')'}
                
            end
        end
        if /src *= *\"(.*?)\"/ =~ line    
            url = $1
            if /http.*/ !~ url
                line.gsub!(/src *= *\"(.*?)\"/){|m| 'src="' + urla+url+'"'}
            end
        end 
        if /href *= *\"(.*?)\"/ =~ line    
            url = $1
            if /http.*/ !~ url
                line.gsub!(/href *= *\"(.*?)\"/){|m| 'href="' + url+url+'"'}
            end 
        end 
        str2 += line
    }

    f=File.open('temp.md', 'w')
    f.puts(str2)
    f.close()

    #if otitle == "main.html"
    #    otitle = "index.html"
    #    ofn = outdir + otitle
    #end 
    cmd = "pandoc --template=template2.html --metadata pagetitle=\"#{otitle}\" temp.md -o #{ofn}"
    print cmd, "\n"
    system(cmd)
}

