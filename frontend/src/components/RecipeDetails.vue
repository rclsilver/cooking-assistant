<template>
  <v-layout row>
    <v-flex xs12 sm10 offset-sm1>
      <v-card v-if="recipe !== null">
        <v-img
          :src="recipe.picture_url"
          height="400px"
        >
        </v-img>
        <v-card-title primary-title>
          <v-layout>
            <v-flex xs12>
              <v-layout row wrap>
                <v-flex xs12>
                  <div>
                    <div class="headline">{{ recipe.title }}</div>
                    <div class="grey--text" v-if="recipe.author !== null">Par {{ recipe.author.username }}</div>
                    <div class="grey--text"><u>Source</u> : <a target="_blank" :href="recipe.source_url">{{ recipe.source_url }}</a></div>
                  </div>
                </v-flex>
              </v-layout>
              <v-divider/>
              <v-layout row wrap align-center class="infos">
                <v-flex xs2>
                  <div class="label">Note</div>
                  <div class="value">
                    <v-rating
                      :value="recipe.rate"
                      half-increments
                      readonly
                      size="14"
                      color="amber"
                    ></v-rating>
                  </div>
                </v-flex>
                <v-flex xs2>
                  <div class="label">Préparation</div>
                  <div class="value">{{ formatDuration(recipe.preparation_time) }}</div>
                </v-flex>
                <v-flex xs2>
                  <div class="label">Cuisson</div>
                  <div class="value">{{ formatDuration(recipe.cooking_time) }}</div>
                </v-flex>
                <v-flex xs2>
                  <div class="label">Personnes</div>
                  <div class="value">{{ recipe.persons }}</div>
                </v-flex>
                <v-flex xs2>
                  <div class="label">{{ getCostLabel(recipe.cost) }}</div>
                  <div class="value">
                    <v-progress-circular
                      :value="recipe.cost * 100 / 4"
                      color="primary"
                      :title="recipe.cost"
                    ></v-progress-circular>
                  </div>
                </v-flex>
                <v-flex xs2>
                  <div class="label">{{ getDifficultyLabel(recipe.difficulty) }}</div>
                  <div class="value">
                    <v-progress-circular
                      :value="recipe.difficulty * 100 / 3"
                      color="primary"
                      :title="recipe.difficulty"
                    ></v-progress-circular>
                  </div>
                </v-flex>
              </v-layout>
            </v-flex>
          </v-layout>
        </v-card-title>
        <v-container>
          <v-layout row>
            <v-flex xs3 class="ingredients">
              <h2>Ingrédients</h2>
              <ul>
                <li
                  v-for="ingredient in recipe.ingredients"
                  :key="ingredient.id"
                >
                  <span class="picture">
                    <v-avatar
                      size="48"
                      color="grey lighten-4"
                    >
                      <v-img :src="ingredient.ingredient.picture_url"/>
                    </v-avatar>
                  </span>
                  <span class="label">
                    {{ getIngredientQuantityLabel(ingredient) }}
                  </span>
                </li>
              </ul>
            </v-flex>
            <v-flex xs9 class="steps">
              <h2>Préparation</h2>
              <ol>
                <li v-for="(step, index) in recipe.steps" :key="index">{{ step }}</li>
              </ol>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default {
    props: {
      recipeId: String,
    },
    data () {
      return {
        recipe: null,
      }
    },
    methods: {
      getCostLabel(value) {
        if(1 === value) {
          return 'bon marché'
        } else if(2 === value) {
          return 'coût moyen'
        } else if(3 === value) {
          return 'assez cher'
        } else {
          return value
        }
      },
      getDifficultyLabel(value) {
        if(1 === value) {
          return 'très facile'
        } else if(2 === value) {
          return 'facile'
        } else if(3 === value) {
          return 'niveau moyen'
        } else if(4 === value) {
          return 'difficile'
        } else {
          return value
        }
      },
      formatDuration(total_minutes) {
        if (null === total_minutes) {
          return '-'
        }

        let hours = Math.floor(total_minutes / 60)
        let minutes = total_minutes - (hours * 60)
        let result = ''

        if(hours > 0) {
          result += hours.toString() + ' h'
        }

        if(minutes > 0) {
          if(hours > 0) {
            result += ' '
          }

          if(minutes < 10 && hours > 0) {
            result += '0'
          }
          result += minutes.toString() + ' m'
        }

        return result
      },
      getIngredientQuantityLabel(ingredient) {
        if(null === ingredient.quantity) {
          return ingredient.ingredient.label
        } else if(null === ingredient.unit) {
          return parseFloat(ingredient.quantity) + ' ' + ingredient.ingredient.label
        } else if (ingredient.quantity > 1 && null !== ingredient.unit.label_plural) {
          return parseFloat(ingredient.quantity) + ' ' + ingredient.unit.label_plural + ' de ' + ingredient.ingredient.label
        } else {
          return parseFloat(ingredient.quantity) + ' ' + ingredient.unit.label + ' de ' + ingredient.ingredient.label
        }
      },
      load() {
        this.$api.recipes.get({id: this.recipeId}).then(response => {
          this.recipe = response.body
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.dispatch('alert/error', 'Unable to load recipe')
        })
      },
    },
    mounted: function() {
      this.load()
    },
  }
</script>

<style lang="scss" scoped>
  hr {
    margin: 1em;
  }

  h2, .infos .label {
    color: orange;
  }

  .infos {
    text-align: center;

    .label {
      font-weight: bold;
      font-size: 1em;
      text-transform: capitalize;
    }

    .value {
      font-size: 3em;
    }
  }

  .ingredients {
    ul {
      padding: 0;
    }

    li {
      list-style: none;
    }
  }

  .steps {
    li {
      padding-bottom: 1em;
    }
  }
</style>
