User.create!([
               {
                 name: 'Luke Skywalker',
                 email: 'luke@theforce.com',
                 password: 'test1234'
               },
               {
                 name: 'Darth Vader',
                 email: 'vader@thedarkside.com',
                 password: 'test1234'
               }
             ])

Character.create!([
                    {
                      name: 'Ryu Nightbreeze',
                      level: 10,
                      character_class: 'fighter',
                      race: 'half_orc'
                    },
                    {
                      name: 'Camus Moongem',
                      level: 10,
                      character_class: 'wizard',
                      race: 'gnome'
                    },
                    {
                      name: 'Dalton Rhode',
                      level: 10,
                      character_class: 'warlock',
                      race: 'human'
                    },
                    {
                      name: 'Darkwing Copperkettle',
                      level: 10,
                      character_class: 'sorcerer',
                      race: 'dragonborn'
                    }
                  ])
