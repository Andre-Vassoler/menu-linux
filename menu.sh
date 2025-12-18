#!/bin/bash

while true; do
    clear
    echo "===== MENU DO SISTEMA ====="
    echo "1) Contar arquivos contendo string"
    echo "2) Alterar permissões de um arquivo"
    echo "3) Criar um novo diretório"
    echo "4) Mostrar conteúdo de um arquivo"
    echo "5) Exibir informações do sistema"
    echo "6) Detalhes de um arquivo"
    echo "7) Listar processos ativos"
    echo "8) Calculadora (soma e subtração)"
    echo "9) Conversão de temperatura"
    echo "10) Criar anotação"
    echo "0) Sair"
    echo "==========================="
    read -p "Escolha uma opção: " opt

    case $opt in
        1)
            read -p "Digite o caminho do diretório: " dir
            read -p "Digite a string a ser buscada: " str
            if [ ! -d "$dir" ]; then
                echo "Diretório inválido!"
            else
                count=$(ls "$dir" | grep "$str" | wc -l)
                echo "Total de arquivos encontrados: $count"
            fi
            read -p "Pressione ENTER para continuar..."
        ;;

        2)
            read -p "Caminho do arquivo: " file
            if [ ! -f "$file" ]; then
                echo "Arquivo não existe!"
            else
                read -p "Digite a permissão (ex: 755): " perm
                chmod $perm "$file"
                echo "Permissões alteradas com sucesso!"
            fi
            read -p "Pressione ENTER para continuar..."
        ;;

        3)
            read -p "Digite o caminho do novo diretório: " newdir
            if [ -d "$newdir" ]; then
                echo "Diretório já existe!"
            else
                mkdir -p "$newdir"
                echo "Diretório criado com sucesso!"
            fi
            read -p "Pressione ENTER para continuar..."
        ;;

        4)
            read -p "Digite o caminho do arquivo: " file
            if [ ! -f "$file" ]; then
                echo "Arquivo não encontrado!"
            else
                cat "$file"
            fi
            read -p "Pressione ENTER para continuar..."
        ;;

        5)
            echo "Memória livre:"
            free -b | grep Mem
            echo
            echo "Modelo da CPU:"
            lscpu | head -5 
            echo
            echo "Espaço livre no disco:"
            df -h /
            read -p "Pressione ENTER para continuar..."
        ;;

        6)
            read -p "Digite o caminho do arquivo: " file
            if [ ! -f "$file" ]; then
                echo "Arquivo não existe!"
            else
                ls -l "$file"
            fi
            read -p "Pressione ENTER para continuar..."
        ;;

        7)
            echo "Processos ativos:"
            ps aux 
	    read -p "Pressione ENTER para voltar.."
        ;;

        8)
            while true; do
                clear
                echo "===== CALCULADORA ====="
                echo "1) Soma"
                echo "2) Subtração"
                echo "0) Voltar"
                echo "========================"
                read -p "Escolha uma opção: " calc

                case $calc in
                    1)
                        read -p "Digite o primeiro número: " a
                        read -p "Digite o segundo número: " b
                        echo "Resultado: $((a + b))"
                        read -p "ENTER para continuar..." ;;
                    2)
                        read -p "Digite o primeiro número: " a
                        read -p "Digite o segundo número: " b
                        echo "Resultado: $((a - b))"
                        read -p "ENTER para continuar..." ;;
                    0) break ;;
                    *) 
                        echo "Opção inválida!"
                        read -p "ENTER para continuar..." ;;
                esac
            done
        ;;

        9)
            while true; do
                clear
                echo "===== CONVERSOR DE TEMPERATURA ====="
                echo "1) Celsius -> Fahrenheit"
                echo "2) Celsius -> Kelvin"
                echo "3) Fahrenheit -> Celsius"
                echo "4) Fahrenheit -> Kelvin"
                echo "5) Kelvin -> Celsius"
                echo "6) Kelvin -> Fahrenheit"
                echo "0) Voltar"
                echo "===================================="
                read -p "Escolha uma opção: " temp

                case $temp in
                    1)
                        read -p "Temperatura em Celsius: " c
                        f=$(echo "$c * 9 / 5 + 32" | bc -l)
                        echo "Resultado: $f °F"
                        read -p "ENTER para continuar..." ;;
                    2)
                        read -p "Temperatura em Celsius: " c
                        k=$(echo "$c + 273.15" | bc -l)
                        echo "Resultado: $k K"
                        read -p "ENTER para continuar..." ;;
                    3)
                        read -p "Temperatura em Fahrenheit: " f
                        c=$(echo "($f - 32) * 5 / 9" | bc -l)
                        echo "Resultado: $c °C"
                        read -p "ENTER para continuar..." ;;
                    4)
                        read -p "Temperatura em Fahrenheit: " f
                        k=$(echo "($f - 32) * 5 / 9 + 273.15" | bc -l)
                        echo "Resultado: $k K"
                        read -p "ENTER para continuar..." ;;
                    5)
                        read -p "Temperatura em Kelvin: " k
                        c=$(echo "$k - 273.15" | bc -l)
                        echo "Resultado: $c °C"
                        read -p "ENTER para continuar..." ;;
                    6)
                        read -p "Temperatura em Kelvin: " k
                        f=$(echo "($k - 273.15) * 9 / 5 + 32" | bc -l)
                        echo "Resultado: $f °F"
                        read -p "ENTER para continuar..." ;;
                    0) break ;;
                    *)
                        echo "Opção inválida!"
                        read -p "ENTER para continuar..." ;;
                esac
            done
        ;;

        10)
            clear
            echo "===== CRIAR ANOTAÇÃO ====="
            read -p "Digite sua anotação: " anot

            dir_anot="$HOME/anotacoes"
            mkdir -p "$dir_anot"

            nome="anotacao_$(date +"%Y-%m-%d").txt"
            echo "$anot" > "$dir_anot/$nome"

            echo "Anotação salva em: $dir_anot/$nome"
            read -p "ENTER para continuar..."
        ;;

        0)
            echo "Saindo..."
            exit 0
        ;;

        *)
            echo "Opção inválida!"
            read -p "Pressione ENTER para continuar..."
        ;;
    esac
done
