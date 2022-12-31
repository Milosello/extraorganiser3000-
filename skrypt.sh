 #!/bin/bash
      function kompresja  {
         clear
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --menu "Wybierz opcje:"  22 76 16\
         1 "kompresja pliku" \
         2 "wypakowanie z archiwum" \
         3 "wyświetlanie zawartości archiwum" \
         4 "usunięcie pliku" 2> komp
         sel=$?
         komp=`cat komp`
         case "$sel" in
           0) case "$komp" in
                # 1 - archiwizacja i kompresja tak/nie
                1) dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa pliku: " 22 76 2> dane
                  sel=$?
                  dane=`cat dane`
                  case "$sel" in
                    0) clear; dialog --title "Okno wprowadzania danych" \
                        --inputbox "Scieżka do pliku który ma zostac zarchiwizowany" 22 76 2> miejsce
                        sel=$?
                        case "$sel" in
                          0) clear; dialog --title "Kompresja..." \
                              --yesno "czy archiwum ma zostać poddane kompresji?" 22 76 
                              response=$?
                              case $response in
                                 0) tar -zcf $dane $miejsce
                                    clear;;
                                 1) tar -cf $dane $miejsce
                                    clear;;
                                 255) main;;
                              esac;;
                          1) clear; main ;;
                          255) clear; exit "" ;;
                        esac ;;
                    1) clear; main "" ;;
                    255) clear; exit "" ;;
                  esac ;;
                # 2 - rozpakowanie i dekompresja tak/nie
                2) dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa pliku: " 22 76 2> dane
                  sel=$?
                  dane=`cat dane`
                  case "$sel" in
                    0) clear; dialog --title "rozpakowywanie..." \
                              --yesno "czy archiwum jest skopresowane?" 22 76
                              response=$?
                              case $response in
                                 0) tar -zxf $dane $miejsce
                                    clear;;
                                 1) tar -xf $dane $miejsce
                                    clear;;
                                 255) main;;
                              esac;;
                          1) clear; main ;;
                          255) clear; exit "" ;;
                    1) clear; main "" ;;
                    255) clear; exit "" ;;
                  esac ;;
                3) dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa pliku: " 22 76 2> dane
                  sel=$?
                  dane=`cat dane`
                  case "$sel" in
                    0) tar -tf $dane>zawartosc
                    zawartosc=`cat zawartosc`
                    clear
                    dialog --title "zawartosc" --msgbox "$zawartosc" 22 76
                    clear;;           
                    1) clear; main "" ;;
                    255) clear; exit "" ;;
                  esac ;;
                4)  dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa pliku: " 22 76 2> dane
                  sel=$?
                  dane=`cat dane`
                  case "$sel" in
                    0) clear; dialog --title "usuwanie" \
                              --yesno "czy napewno chcesz usunąć $dane?" 22 76 
                              response=$?
                              case $response in
                                 0) rm -rf $dane; ls >sprawdzenie
                                       dialog --title "potwierdzenie" --textbox ./sciezka 22 76;;
                                 1) main;;
                                 255) main;;
                              esac;;
                          1) clear; main ;;
                          255) clear; exit "" ;;
                    1) clear; main "" ;;
                    255) clear; exit "" ;;
                  esac ;;             
              esac ;;
          1) clear; main ;;
          255) clear; exit ;;
         esac
      }
      function uzytkownik  {
         dialog --title "Edytor systemu 3000" --menu "Wybierz opcje:"  22 76 16\
         1 "wyświetl plik passwd"\
         2 "wyświetl plik shadow"\
         3 "wyswietl plik group"\
         4 "Dodaj użytkownika"\
         5 "Usuń użytkownika"\
         6 "Dodaj grupę"\
         7 "Usuń grupę" 2> uzyt
         sel=$?
         uzyt=`cat uzyt`
         case "$sel" in
           0)  case "$uzyt" in
                1) clear ;dialog --title "passwd" --textbox /etc/passwd 22 76 ;;
                2) clear ;dialog --title "shadow" --textbox /etc/shadow 22 76 ;;
                3) clear ;dialog --title "group" --textbox /etc/group 22 76 ;;
                4) clear ;dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa użytkownika" 22 76 2> nazwa
                  sel=$?
                  nazwa=`cat nazwa`
                  case "$sel" in
                    0) clear ;dialog --title "Okno wprowadzania danych" \
                        --inputbox "Grupa, do której ma należeć użytkowanik (Grupa musi istnieć)" 22 76 2> grupa
                        sel=$?
                        case "$sel" in
                          0) clear ;dialog --title "Okno wprowadzania danych" \
                              --inputbox "Powłoka, w której ma pracować użytkowanik" 22 76 2> powloka
                              sel=$?
                              grupa=`cat grupa`
                              nazwa=`cat nazwa`
                              powloka=`cat powloka`
                              case $sel in
                                 0) sudo useradd -g $grupa -s $powloka -m -d /home/$nazwa $nazwa; dialog --title "potwierdzenie" --textbox /etc/passwd 22 76;;
                                 1) main;;
                                 255) main;;
                              esac;;
                          1) clear; main ;;
                          255) clear; exit ;;
                        esac ;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                  esac ;;
                5) clear ;dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa użytkowanika" 22 76 2>nazwa 
                  sel=$?
                  nazwa=`cat nazwa`
                  case "$sel" in
                    0) clear; dialog --title "usuwanie" \
                              --yesno "czy napewno chcesz usunąć $dane?" 22 76 
                              response=$?
                              nazwa=`cat nazwa`
                              case $response in
                                 0) sudo userdel $nazwa; dialog --title "potwierdzenie" --textbox /etc/passwd 22 76;;
                                 1) main;;
                                 255) main;;
                              esac;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                    esac ;;
                6) clear ;dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa grupy" 22 76 2>nazwa 
                  sel=$?
                  nazwa=`cat nazwa`
                  case "$sel" in
                    0) clear; dialog --title "Okno wprowadzania danych" \
                              --inputbox "Podaj GID dla grupy (musi być unikalne!)" 22 76 2> gid
                              sel=$?
                              nazwa=`cat nazwa`
                              gid=`cat gid`
                              case $sel in
                                 0) sudo groupadd -g $gid $nazwa; dialog --title "potwierdzenie" --textbox /etc/group 22 76;;
                                 1) main;;
                                 255) main;;
                              esac;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                    esac ;;
                7) clear ; dialog --title "Okno wprowadzania danych" \
                  --inputbox "Nazwa grupy" 22 76 2>nazwa 
                  sel=$?
                  nazwa=`cat nazwa`
                  case "$sel" in
                    0) clear; dialog --title "usuwanie" \
                              --yesno "czy napewno chcesz usunąć $dane?" 22 76 
                              response=$?
                              nazwa=`cat nazwa`
                              case $response in
                                 0) sudo groupdel $nazwa; dialog --title "potwierdzenie" --textbox /etc/group 22 76;;
                                 1) main;;
                                 255) main;;
                              esac;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                    esac ;;
                255) clear; exit;;
                esac;;
         1) clear; main ;;
         255) clear; exit;;
         esac 
      }
      function instrukcja  {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj nazwę programu do którego chciałbyś znaleść instrukcję"  22 76\
         2>nazwa 
                  sel=$?
                  nazwa=`cat nazwa`
                  case "$sel" in
                    0) clear; 
                              (
                              licznik=0
                              while [ $licznik -lt 100 ]
                              do
                              licznik=`expr $licznik + 1`
                              echo $licznik
                              sleep 0,03
                              done )| dialog --gauge "Ładowanie instrukcji" 22 76 0; man $nazwa;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                    esac 
      }
      function sciezka  {
         clear; 
         (
         licznik=0
         while [ $licznik -lt 100 ]
         do
         licznik=`expr $licznik + 1`
         echo $licznik
         sleep 0,03
         done )| dialog --gauge "Ładowanie ścieżki" 22 76 0; pwd>sciezka; \
         dialog --title "Aktualnie znajdujesz się w: " --textbox ./sciezka 22 76
      }
      function zmiana  {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj scieżkę do zmiany"  22 76 \
        2>sciezka
                  sel=$?
                  nazwa=`cat sciezka`
                  case "$sel" in
                    0) clear; cd $sciezka; pwd>sciezka; dialog --title "potwierdzenie" --textbox ./sciezka 22 76;sleep 5 ;main;;
                    1) clear; main  ;;
                    255) clear; exit  ;;
                    esac  
      }
      function folder  {
         
         clear ;dialog --title "Okno wprowadzania danych" --inputbox "Podaj scieżkę folderu, którego zawartość chciałbyś wyświetlić" 22 76\
            2>sciezka
            sel=$?
            sciezka=`cat sciezka`
         MIEJ="$sciezka"
         ls>sciezka
        dialog --title "Zawartość folderu: $sciezka" --textbox ./sciezka 22 76
      }
      function stworz  {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj nazwę pliku tekstowego"  22 76 \
         2>nazwa
         sel=$?
            nazwa=`cat nazwa`
            touch $nazwa
            ls -l $nazwa>sciezka
        dialog --title "potwierdzenie" --textbox ./sciezka 22 76
      }
      function uprawnienia  {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputmenu "Wybierz uprawnienia dla użytkownika:"  22 76 16\
         1 "000" \
         2 "x" \
         3 "w" \
         4 "wx" \
         5 "r" \
         6 "rx" \
         7 "rwx" 2>usr
         usr=`cat usr`
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputmenu "Wybierz uprawnienia dla grupy:"  22 76 16\
         1 "000" \
         2 "x" \
         3 "w" \
         4 "wx" \
         5 "r" \
         6 "rx" \
         7 "rwx" 2>grp
         grp=`cat grp`
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputmenu "Wybierz uprawnienia dla innych:"  22 76 16\
         1 "000" \
         2 "x" \
         3 "w" \
         4 "wx" \
         5 "r" \
         6 "rx" \
         7 "rwx" 2>oth
         oth=`cat oth`
         PLIK=$(dialog --stdout --title "Wybierz plik" --fselect / 22 76)
         sudo chmod $usr$grp$oth ${PLIK}
         ls -l ${PLIK}>sprawdzenie
         sprawdzenie=`cat sprawdzenie`
         dialog --title "Potwierdzenie" --textbox ./sprawdzenie 22 76; sleep 5; main
      }
      function edytor  {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj nazwę pliku tekstowego"  22 76 \
         2>nazwa
         sel=$?
            nazwa=`cat nazwa`
            nano $nazwa
      }
      function dowiazanie {
         dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj ścieżkę pliku do którego ma zostać dowiązene dowiązanie"  22 76 \
         2>cel
         sel=$?
            cel=`cat cel`
            clear
            dialog --title "Edytor systemu 3000" --backtitle "Autor: Miłosz Hillar" --inputbox "Podaj nazwę dowiązania"  22 76 \
            2>nazwa
            sel=$?
            nazwa=`cat nazwa`
            touch $nazwa
            dialog --title "Dowiazanie" \
                              --yesno "Tak(Dowiązanie twarde), Nie(dowiązanie symboliczne)" 22 76 
                              response=$?
                              nazwa=`cat nazwa`
                              case $response in
                                 0) ln $cel $nazwa;;
                                 1) ln -s $cel $nazwa;;
                                 255) main;;
                              esac
                    
            ls -l $nazwa>sciezka
        dialog --title "potwierdzenie" --textbox ./sciezka 22 76
      }
      function czyscik  {
         rm -r grp nazwa powloka sprawdzenie grupa wybor cel komp oth wynik dane sciezka usr zawartosc miejsce zaznaczone gid uzyt
      }
      function main {
         dialog --title "Edytor systemu 3000" --menu "Wybierz opcje:"  22 76 16\
         1 "Kompresja i archiwizacja" \
         2 "Zarzadzanie użytkownikami" \
         3 "Wyświetl instrukcje do programu" \
         4 "Ścieżka do miejsca" \
         5 "Zmiana położenia" \
         6 "wyświetlanie zawartości" \
         7 "Tworzenie pliku" \
         8 "Zarzadzanie własnością i uprawnieniami" \
         9 "Edycja zawartości pliku" \
         10 "Stwórz dowiązanie" \
         11 "Zamknij komputer" \
         12 "Wyjscie ze skryptu" \
         13 "czyścik" \
         2> wynik
         sel=$?
         wynik=`cat wynik`
            case "$sel" in
              0) case "$wynik" in
                  1)   kompresja ;;
                  2)   uzytkownik ;;
                  3)   instrukcja ;;
                  4)   sciezka ;;
                  5)   zmiana ;;
                  6)   folder ;;
                  7)    stworz ;;
                  8)  uprawnienia ;;
                  9)  edytor ;;
                  10)  dowiazanie ;;
                  11)  halt ;;
                  12)  exit;;
                  13) czyscik;;
                 esac ;;
             1) clear; main ;;
             255) clear; exit;
            esac
                     }
clear
czyscik
main