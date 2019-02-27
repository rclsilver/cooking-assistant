<template>
  <v-container grid-list-md>
    <v-layout row wrap>
      <v-flex
        v-if="searchBar"
        xs12
      >
        <v-text-field
          v-model="searchPattern"
          clearable
          solo
          autofocus
          type="text"
          append-icon="search"
          @keypress.enter="search()"
          @click:append="search()"
          @click:clear="clearSearch()"
        >
        </v-text-field>
      </v-flex>
      <v-flex
        xs12
        v-if="loader.finished && !loader.items.length"
      >
        <p>No recipe found with those filters.</p>
      </v-flex>
      <v-layout row wrap>
        <template v-if="'vcard' === mode">
          <v-flex
            xs12
            sm3
            v-for="recipe in loader.items"
            :key="recipe.id"
          >
            <drag
              :draggable="draggable"
              :transfer-data="{ recipe }"
              @dragstart="(transferData, nativeEvent) => $emit('drag-start', transferData, nativeEvent)"
              @dragend="(transferData, nativeEvent) => $emit('drag-end', transferData, nativeEvent)"
            >
              <v-hover>
                <v-card
                  slot-scope="{ hover }"
                  :class="`elevation-${hover ? 24 : 2}`" 
                  flat
                  tile
                  :to="{name: 'recipe-details', params: { id: recipe.id }}"
                >
                  <v-img
                    :aspect-ratio="16/9"
                    :src="recipe.picture_url"
                  ></v-img>
                  <v-card-title>
                    <div>
                      <span class="d-flex">{{ recipe.title | truncate(27, '...')}}</span>
                      <div class="d-flex">
                        <v-rating
                          :value="recipe.rate"
                          color="amber"
                          dense
                          half-increments
                          readonly
                          size="14"
                        ></v-rating>
                      </div>
                    </div>
                  </v-card-title>
                </v-card>
              </v-hover>
            </drag>
          </v-flex>
        </template>
        <template v-if="'avatar' === mode">
          <v-flex
            xs1
            v-for="recipe in loader.items"
            :key="recipe.id"
          >
            <drag
              :draggable="draggable"
              :transfer-data="{ recipe }"
              @dragstart="(transferData, nativeEvent) => $emit('drag-start', transferData, nativeEvent)"
              @dragend="(transferData, nativeEvent) => $emit('drag-end', transferData, nativeEvent)"
            >
              <template slot="image">
                <v-avatar>
                  <v-img
                    :aspect-ratio="16/9"
                    :src="recipe.picture_url"
                  ></v-img>
                </v-avatar>
              </template>
              <a
                :href="'/recipes/' + recipe.id"
                :title="recipe.title"
              >
                <v-hover>
                  <v-avatar 
                    slot-scope="{ hover }"
                    :class="`elevation-${hover ? 4 : 2}`"
                  >
                    <v-img
                      :aspect-ratio="16/9"
                      :src="recipe.picture_url"
                    ></v-img>
                  </v-avatar>
                </v-hover>
              </a>
            </drag>
          </v-flex>
        </template>
      </v-layout>
    </v-layout>
    <v-layout row v-if="loader.loading">
      <v-container text-xs-center>
        <v-flex xs12>
          <v-progress-circular indeterminate color="primary"></v-progress-circular>
        </v-flex>
      </v-container>
    </v-layout>
  </v-container>
</template>

<script>
  import InfiniteLoader from '@/utils/infinite-loader'

  export default {
    props: {
      dataSource: Function,
      searchBar: {
        type: Boolean,
        default: true,
      },
      pageSize: {
        type: Number,
        default: 40,
      },
      mode: {
        type: String,
        default: 'vcard',
        validator: function(value) {
          return ['vcard', 'avatar'].indexOf(value) !== -1
        }
      },
      draggable: {
        type: Boolean,
        default: false,
      },
    },
    data () {
      return {
        loader: new InfiniteLoader(this.dataSource ? this.dataSource : this.$api.recipes.get, this.pageSize),
        searchPattern: '',
      }
    },
    methods: {
      load() {
        this.loader.load().then(() => {
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.dispatch('alert/error', 'Unable to load list of recipes')
        })
      },
      scroll() {
        window.onscroll = () => {
          let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.offsetHeight;

          if (bottomOfWindow) {
            this.load()
          }
        }
      },
      search() {
        if(this.searchPattern !== null && this.searchPattern.length > 0) {
          this.loader.setFilters({search: this.searchPattern})
        } else {
          this.loader.setFilters({})
        }
        this.load()
      },
      clearSearch() {
        this.searchPattern = null
        this.search()
      },
      refresh() {
        this.loader.reset()
        this.loader.load()
      },
    },
    mounted: function() {
      this.load()
      this.scroll()
    }
  }
</script>
