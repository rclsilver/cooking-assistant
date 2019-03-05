<template>
  <v-card>
    <v-toolbar v-if="period !== null">
      <span class="headline">Period from {{ period.start_date }} to {{ period.end_date }}</span>
      <drop @drop="(data) => deleteRecipe(data.recipe)">
        <v-btn
          fab
          absolute
          bottom
          right
          color="red"
          v-if="dragging"
        >
          <v-icon>delete</v-icon>
        </v-btn>
      </drop>
    </v-toolbar>
    <v-container class="text-xs-center" v-if="period === null">
      <v-progress-circular indeterminate color="primary"></v-progress-circular>
    </v-container>
    <v-container v-if="period !== null && recipes !== null">
      <drop
        @drop="(data) => unsetRecipeDate(data.recipe)"
        @dragover="(data, event) => unsetDateDragover(event)"
      >
        <v-container
          grid-list-md
          class="unset-date-drop-zone"
          :class="{ dragging: draggingWithDate }"
        >
          <v-layout row wrap>
            <v-flex
              xs12
              v-if="recipes.finished && !recipesWithoutDate.length"
            >
              <p>No more recipe found in this period.</p>
            </v-flex>
            <v-flex
              xs1
              v-for="recipe in recipesWithoutDate"
              :key="recipe.id"
            >
              <drag
                :transfer-data="{ recipe }"
                @dragstart="draggingWithoutDate = true"
                @dragend="draggingWithoutDate = false"
              >
                <template slot="image">
                  <v-avatar>
                    <v-img
                      :aspect-ratio="16/9"
                      :src="recipe.picture_url"
                    ></v-img>
                  </v-avatar>
                </template>
                <v-tooltip bottom>
                  <template v-slot:activator="{ on }">
                    <v-hover >
                      <v-avatar 
                        v-on="on"
                        slot-scope="{ hover }"
                        :class="`elevation-${hover ? 4 : 2}`"
                      >
                        <v-img
                          :aspect-ratio="16/9"
                          :src="recipe.picture_url"
                        ></v-img>
                      </v-avatar>
                    </v-hover>
                  </template>
                  <span>{{ recipe.title }}</span>
                </v-tooltip>
              </drag>
            </v-flex>
          </v-layout>
        </v-container>
      </drop>
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
                  <drag
                    v-if="recipesWithDate.hasOwnProperty(date) && recipesWithDate[date].hasOwnProperty(2)"
                    :transfer-data="{ recipe: recipesWithDate[date][2][0] }"
                    @dragstart="draggingWithDate = true"
                    @dragend="draggingWithDate = false"
                  >
                    <template slot="image">
                      <v-avatar>
                        <v-img
                          :aspect-ratio="16/9"
                          :src="recipesWithDate[date][2][0].picture_url"
                        ></v-img>
                      </v-avatar>
                    </template>
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on }">
                        <v-hover>
                          <v-avatar
                            v-on="on"
                            slot-scope="{ hover }"
                            :class="`elevation-${hover ? 4 : 2}`"
                          >
                            <v-img
                              :aspect-ratio="16/9"
                              :src="recipesWithDate[date][2][0].picture_url"
                            ></v-img>
                          </v-avatar>
                        </v-hover>
                      </template>
                      <span>{{ recipesWithDate[date][2][0].title }}</span>
                    </v-tooltip>
                  </drag>
                  <drop
                    v-else
                    @drop="(data) => setRecipeDate(data.recipe, date, 2)"
                  >
                    <v-avatar
                      size="48"
                      color="grey lighten-4"
                      class="drop-zone"
                      :class="{ dragging: dragging }"
                    >
                      <span v-if="dragging">Lunch</span>
                    </v-avatar>
                  </drop>
                </v-flex>
                <v-flex xs6>
                  <drag
                    v-if="recipesWithDate.hasOwnProperty(date) && recipesWithDate[date].hasOwnProperty(4)"
                    :transfer-data="{ recipe: recipesWithDate[date][4][0] }"
                    @dragstart="draggingWithDate = true"
                    @dragend="draggingWithDate = false"
                  >
                    <template slot="image">
                      <v-avatar>
                        <v-img
                          :aspect-ratio="16/9"
                          :src="recipesWithDate[date][4][0].picture_url"
                        ></v-img>
                      </v-avatar>
                    </template>
                    <v-tooltip bottom>
                      <template v-slot:activator="{ on }">
                        <v-hover>
                          <v-avatar
                            v-on="on"
                            slot-scope="{ hover }"
                            :class="`elevation-${hover ? 4 : 2}`"
                          >
                            <v-img
                              :aspect-ratio="16/9"
                              :src="recipesWithDate[date][4][0].picture_url"
                            ></v-img>
                          </v-avatar>
                        </v-hover>
                      </template>
                      <span>{{ recipesWithDate[date][4][0].title }}</span>
                    </v-tooltip>
                  </drag>
                  <drop
                    v-else
                    @drop="(data) => setRecipeDate(data.recipe, date, 4)"
                  >
                    <v-avatar
                      size="48"
                      color="grey lighten-4"
                      class="drop-zone"
                      :class="{ dragging: dragging }"
                    >
                      <span v-if="dragging">Dinner</span>
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
  import InfiniteLoader from '@/utils/infinite-loader'

  export default {
    props: {
      periodId: String,
    },
    data () {
      return {
        period: null,
        recipes: null,
        draggingWithDate: false,
        draggingWithoutDate: false,
      }
    },
    computed: {
      dragging() {
        return this.draggingWithDate || this.draggingWithoutDate
      },
      recipesWithDate() {
        const results = {}

        if(this.recipes !== null) {
          this.recipes.items.filter(
            item => item.date !== null
          ).forEach(item => {
            if (!results.hasOwnProperty(item.date)) {
              results[item.date] = {}
            }
            if (!results[item.date].hasOwnProperty(item.meal)) {
              results[item.date][item.meal] = []
            }

            let result = item.recipe
            result.link = item
            delete result.link.recipe

            results[item.date][item.meal].push(result)
          })
        }

        return results
      },
      recipesWithoutDate() {
        if(this.recipes !== null) {
          return this.recipes.items.filter(
            item => item.date === null
          ).map(
            item => {
              let result = item.recipe
              result.link = item
              delete result.link.recipe
              return result
            }
          )
        } else {
          return []
        }
      },
    },
    methods: {
      load() {
        this.$api.periods.get({id: this.periodId}).then(response => {
          this.$store.dispatch('alert/clear')
          this.period = response.body
          this.recipes = new InfiniteLoader((params={}) => this.$api.periods.getRecipes({id: this.periodId, ...params}), 0)
          this.loadRecipes()
        }, () => {
          this.$store.disatch('alert/error', 'Unable to load period')
        })
      },
      loadRecipes() {
        this.recipes.load().then(() => {
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.dispatch('alert/error', 'Unable to load list of recipes')
        })
      },
      setRecipeDate(recipe, date, meal) {
        this.$api.periods.updateRecipe({
          id: this.period.id,
          recipeId: recipe.link.id
        }, {
          date: date,
          meal: meal,
        }).then(() => {
          this.recipes.reset()
          this.loadRecipes()
        }, () => {
          this.$store.dispatch('alert/error', 'Error while updating recipe')
        })
      },
      unsetRecipeDate(recipe) {
        if(recipe.link.date !== null) {
          this.$confirm('Are you sure to reset date for this recipe?').then(choice => {
            if(choice) {
              this.$api.periods.updateRecipe({
                id: this.period.id,
                recipeId: recipe.link.id
              }, {
                date: null,
                meal: null,
              }).then(() => {
                this.recipes.reset()
                this.loadRecipes()
              }, () => {
                this.$store.dispatch('alert/error', 'Error while updating recipe')
              })
            }
          })
        }
      },
      deleteRecipe(recipe) {
        this.$confirm('Are you sure to remove this recipe?').then(choice => {
          if(choice) {
            this.$api.periods.deleteRecipe({id: this.period.id, recipeId: recipe.link.id}, {}).then(() => {
              this.recipes.reset()
              this.loadRecipes()
            }, () => {
              this.$store.dispatch('alert/error', 'Error while removing recipe')
            })
          }
        })
      },
      unsetDateDragover(event) {
        if(this.draggingWithoutDate) {
          event.dataTransfer.dropEffect = 'none'
        }
      },
    },
    mounted: function() {
      this.load()
    } 
  }
</script>

<style lang="scss" scoped>
  %dragging-in-progress {
    border: 2px dashed gray !important;
  }

  .drop-zone.dragging {
    @extend %dragging-in-progress;
  }

  .unset-date-drop-zone.dragging {
    @extend %dragging-in-progress;
  }
</style>
