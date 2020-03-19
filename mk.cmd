pandoc --template=template.html --metadata pagetitle="index.html" testmain.md -o index.html
pandoc --template=template.html --metadata pagetitle="links.html" links.md -o links.html
pandoc --template=template.html --metadata pagetitle="mailinglist.html" mailinglist.md -o mailinglist.html
pandoc --template=template.html --metadata pagetitle="daihyo_yakuin.html" daihyo_yakuin.md -o daihyo_yakuin.html
