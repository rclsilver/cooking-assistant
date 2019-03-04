<template>
  <v-card>
    <v-toolbar v-if="period !== null">
      <span class="headline">Period from {{ period.start_date }} to {{ period.end_date }}</span>
    </v-toolbar>
    <v-container class="text-xs-center" v-if="period === null">
      <v-progress-circular indeterminate color="primary"></v-progress-circular>
    </v-container>
    <v-container v-if="period !== null">
      <recipe-list
        :search-bar="false"
        :page-size="0"
        mode="avatar"
        :draggable="true"
        :data-source="recipesLoader"
      />      
      <v-sheet>
        <v-calendar
          :start="period.start_date"
          :end="period.end_date"
          :weekdays="[1, 2, 3, 4, 5, 6, 0]"
          type="custom-weekly"
          :short-weekdays="false"
        >
          <template v-slot:day="{ date }">
            <v-container grid-list-md text-xs-center>
              <v-layout row wrap>
                <v-flex xs6>
                  <drop @drop="(data, event) => onDrop(date, 2, data, event)">
                    <v-avatar
                      size="48"
                      color="grey lighten-4"
                    >
                    </v-avatar>
                  </drop>
                </v-flex>
                <v-flex xs6>
                  <drop @drop="(data, event) => onDrop(date, 4, data, event)">
                    <v-avatar
                      size="48"
                      color="grey lighten-4"
                    >
                    </v-avatar>
                  </drop>
                </v-flex>
              </v-layout>
            </v-container>
          </template>
        </v-calendar>
      </v-sheet>
    </v-container>
  </v-card>
</template>

<script>
  import RecipeList from '@/components/RecipeList.vue'

  export default {
    components: {
      RecipeList
    },
    props: {
      periodId: String,
    },
    data () {
      return {
        period: null,
        recipesLoader: () => {
          return new Promise((resolve, reject) => {
            return this.$api.periods.getRecipes({ id: this.period.id, offset: 0, limit: 0 }).then(result => {
              result.body.results = result.body.results.map(item => {
                let result = item.recipe
                result.link = item
                delete result.link.recipe
                return result
              })
              resolve(result)
            }, reject)
          })
        },
      }
    },
    methods: {
      load() {
        this.$api.periods.get({id: this.periodId}).then(response => {
          this.period = response.body
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.disatch('alert/error', 'Unable to load period')
        })
      },
      onDrop(date, meal, data, event) {
        console.log(date)
        console.log(meal)
        console.log(data)
        console.log(event)
      },
    },
    mounted: function() {
      this.load()
    } 
  }
</script>
