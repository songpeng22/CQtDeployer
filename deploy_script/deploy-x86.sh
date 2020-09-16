#!/bin/bash
usage="deploy [-h] -- program to deploy qt program

please use like this:
    ./deploy binName deployDir"

# no options , print $usage
if [ "$1" == "" ] ; then
    echo "$usage"
    exit 0
fi

seed=42
while getopts ':hs:' option; do
  case "$option" in
    h) # ./test.sh -h -> echo $usage
        echo "$usage"
        exit
        ;;
    s) # ./test.sh -s 123 -> seed is 123
        seed=$OPTARG
        echo "seed is :$seed"
        ;;
    :)  # ./test.sh -s -> missing argument for -s
        printf "missing argument for -%s\n" "$OPTARG" >&2
        break
        ;;
   \?)  # ./test.sh -? -> illegal option -?
        printf "illegal option: -%s\n" "$OPTARG" >&2
        break
        ;;
  esac
done

# deploy
echo "enter $0 with param -> $@"
echo "param1 -> $1"
echo "param2 -> $2"
sudo rm -vrf $2
sudo mkdir -vp $2
sudo cqtdeployer -bin $1 -qmake /opt/qt-install/bin/qmake -targetDir $2 -verbose 3 deploySystem
sudo chmod -R 775 $2
sudo mv -v $2/$1.sh $2/2.sh
#sudo cp -v 2.sh $2/2.sh



