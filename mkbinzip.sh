cd build/bin;
# without windows
export TARGET_DIR=./; export COMMIT_HASH=`git log -1 --oneline | awk '{print $1}'`; ls -1 $TARGET_DIR | grep -v windows | grep -v xgo | perl -pe 's#.exe##g' | perl -pe 's#\*##g' | awk -v p="$TARGET_DIR" -v c="$COMMIT_HASH" '{print "mkdir -p "p$0"_temp; mv "p$0" "p$0"_temp; mv "p$0"_temp/"$0" "p$0"_temp/gjpy;mv "p$0"_temp "p$0"-"c";zip -r "p$0"-"c".zip "p$0"-"c"/gjpy >>/dev/null; md5 -r "p$0"-"c".zip"}' | sh
# windows
export TARGET_DIR=./; export COMMIT_HASH=`git log -1 --oneline | awk '{print $1}'`; ls -1 $TARGET_DIR | grep windows | perl -pe 's#.exe##g' | perl -pe 's#\*##g' | awk -v p="$TARGET_DIR" -v c="$COMMIT_HASH" '{print "mkdir -p "p$0"_temp; mv "p$0".exe "p$0"_temp; mv "p$0"_temp/"$0".exe "p$0"_temp/gjpy.exe;mv "p$0"_temp "p$0"-"c";zip -r "p$0"-"c".zip "p$0"-"c"/gjpy.exe >>/dev/null; md5 -r "p$0"-"c".zip"}' | sh
