#! /usr/bin/env bash

# changer dir
#cd /tmp

website='http://www.vpnbook.com'
webpage="$website/freevpn"
vpn_file='vpns.html'

choose_vpn(){
  local vpns=($(ls) "EXIT")
  select vpn in "${vpns[@]}"
  do
    case $vpn in
      *.ovpn)
        sudo openvpn $vpn
      ;;
      "EXIT") 
        echo "Exiting program..."
        exit
      ;;
      *)
        echo "Invalid input" >&2
        exit 1
        
  esac
done

}

# download html
wget -q -nv -O $vpn_file $webpage



username=$(xmllint --html --xpath '(//li[contains(text(),"Username")])[2]/strong/text()' \
 $vpn_file 2>/dev/null )



password=$(xmllint --html --xpath \
  '(//li[contains(text(),"Password")])[2]/strong/text()' $vpn_file 2>/dev/null )


echo -e "USE THESE CREDENTIALS\n\nUsername: ${username}\nPassword: ${password}"


vpns=$(xmllint --html --xpath \
  '(//ul[contains(@class,"disc")])[2]//li/a/@href' \
  $vpn_file 2>/dev/null | sed s/href=//g | sed s/\"//g  )

urls=($vpns)

options=("EUROPE1" "EUROPE2" "USA1" "USA2" "CANADA" "GERMANY" "QUIT")

select opt in "${options[@]}"
do
  case $opt in 
    "EUROPE1")
      file="EUROPE1.zip"
      echo -e "Connecting to the EUROPE1 server"
      #wget -q -nv -O $file $website${urls[0]} && unzip -qq -d "EUROPE1" $file
      wget -q -nv -O $file $website${urls[0]} && unzip -qq $file 
      cd EUROPE1/
      choose_vpn
      break
    ;;
    "EUROPE2")
      file="EUROPE2.zip"
      echo -e "Connecting to the EUROPE2 server"
      #wget -q -nv -O $file $website${urls[1]} && unzip -qq -d "EUROPE2" $file
      wget -q -nv -O $file $website${urls[1]} && unzip -qq $file
      cd EUROPE2/
      choose_vpn
      break
    ;;
    "USA1")
      file="USA1.zip"
      echo -e "Connecting to the USA1 server"
      #wget -q -nv -O $file $website${urls[2]} && unzip -qq -d "USA1" $file
      wget -q -nv -O $file $website${urls[2]} && unzip -qq $file
      cd USA1/
      choose_vpn
      break
    ;;
    "USA2")
      file="USA2.zip"
      echo -e "Connecting to the USA2 server"
      #wget -q -nv -O $file $website${urls[3]} && unzip -qq -d "USA2" $file
      wget -q -nv -O $file $website${urls[3]} && unzip -qq $file
      cd USA2/
      choose_vpn
      break
    ;;
    "CANADA")
      file="CANADA.zip"
      echo -e "Connecting to the CANADA server"
      #wget -q -nv -O $file $website${urls[4]} && unzip -qq -d "CANADA" $file
      wget -q -nv -O $file $website${urls[4]} && unzip -qq $file
      cd CANADA/
      choose_vpn
      break
    ;;
    "GERMANY")
      file="GERMANY.zip"
      echo -e "Connecting to the GERMANY server"
      #wget -q -nv -O $file $website${urls[5]} && unzip -qq -d "GERMANY" $file
      wget -q -nv -O $file $website${urls[5]} && unzip -qq $file
      cd GERMANY/
      choose_vpn
      break
    ;;
    "QUIT")
      echo "Exiting program..."
      exit
    ;;
    *)
      echo "Invalid input" >&2
      exit 1
    esac
done
