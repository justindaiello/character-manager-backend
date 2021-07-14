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
                    }
                  ])
