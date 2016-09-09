for i in `ls`; do mv -f $i `echo $i | sed 's/~iphone//g'`; done
