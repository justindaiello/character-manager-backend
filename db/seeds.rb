User.create!([
               {
                 name: 'Luke Skywalker',
                 email: 'luke@theforce.com'
               },
               {
                 name: 'Darth Vader',
                 email: 'vader@thedarkside.com'
               }
             ])

Character.create!([
                    {
                      name: 'Ryu Nightbreeze',
                      level: 10,
                      character_class: 'Fighter',
                      race: 'Half Orc'
                    },
                    {
                      name: 'Camus Moongem',
                      level: 10,
                      character_class: 'Wizard',
                      race: 'Gnome'
                    },
                    {
                      name: 'Dalton Rhode',
                      level: 10,
                      character_class: 'Warlock',
                      race: 'Human'
                    },
                    {
                      name: 'Darkwing Copperkettle',
                      level: 10,
                      character_class: 'Sorcerer',
                      race: 'Dragonborn'
                    }
                  ])
