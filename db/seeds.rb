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
                      race: 'half_orc',
                      user: User.first
                    },
                    {
                      name: 'Camus Moongem',
                      level: 10,
                      character_class: 'wizard',
                      race: 'gnome',
                      user: User.first
                    },
                    {
                      name: 'Dalton Rhode',
                      level: 10,
                      character_class: 'warlock',
                      race: 'human',
                      user: User.first
                    },
                    {
                      name: 'Darkwing Copperkettle',
                      level: 10,
                      character_class: 'sorcerer',
                      race: 'dragonborn',
                      user: User.last
                    }
                  ])
