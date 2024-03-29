#!/bin/bash

# Ce fichier Bash a été pensé pour une distrib Linux Mint qui utilise l'environnement Gnome, si vous désirez l'utiliser sur un autre environnement de bureau, pensez à adapter en conséquence.
sudo echo "Activation de la séquence."

# Définir la date de fin à une minute à partir de maintenant
end_date=$(date -d "+1 minute" +"%Y-%m-%d %H:%M:%S")

echo "Code crée par Julio Le Grand Sage aka foreach pour La Capsule !"

echo "Date actuelle : $(date +"%Y-%m-%d %H:%M:%S")"
echo "Fin de votre accès : $end_date"

# Enregistrez la date de fin dans un fichier
echo "$end_date" > ~/fin_acces_date.txt

# Notification pour informer que la date a été enregistrée
zenity --info --title="Information" --text="Date enregistrée avec succès !"

# Boucle pour afficher les notifications du temps restant chaque 10 secondes
while true; do
    current_date=$(date +"%Y-%m-%d %H:%M:%S")
    remaining_seconds=$(( $(date -d "$end_date" +%s) - $(date -d "$current_date" +%s) ))

    # Si le temps restant est inférieur ou égal à zéro, effectuer les actions finales
    if [ $remaining_seconds -le 0 ]; then
        # Changez le mot de passe de l'utilisateur avec le nouveau mot de passe (modifiez la ligne ci dessous)
        echo -e "Gandalf\nGandalf" | sudo passwd $(whoami)
        

        zenity --warning --title="Fin de location" --text="L'ordinateur va redemarrer, votre mot de passe va être modifié. Veuillez contacter le loueur pour connaitre le mot de passe de secours."

        sudo shutdown -r +1
        



        
        break
    fi

    remaining_minutes=$(( $remaining_seconds / 60 ))
    remaining_seconds=$(( $remaining_seconds % 60 ))

    notify-send "Temps restant" "Il reste $remaining_minutes minutes et $remaining_seconds secondes d'accès."
    zenity  --warning --title="Avertissement avant fin de location" --text="Votre ordinateur va se bloquer si vous ne contactez pas le loueur."

    sleep 10  # Attendre 10 secondes avant de vérifier à nouveau
    
done

echo "Accès expiré."


# code de Julio Le Grand Sage aka foreach pour La Capsule. Vous êtes libres de le modifier, de l'adapter et de le redistribuer.
