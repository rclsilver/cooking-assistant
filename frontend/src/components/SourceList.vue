<template>
  <v-container>
    <v-card>
      <v-toolbar>
        <span class="headline">Sources</span>
        <v-spacer></v-spacer>
        <v-btn icon @click.prevent.stop="refresh()" title="Refresh">
          <v-icon>refresh</v-icon>
        </v-btn>
        <v-menu
          :close-on-content-click="false"
          bottom
          left
          offset-x
          offset-y
        >
          <v-btn slot="activator" icon title="Manage filters">
            <v-icon>filter_list</v-icon>
          </v-btn>
          <v-card>
            <v-card-title>
              <span class="headline">Filters</span>
            </v-card-title>
            <v-list>
              <v-list-tile>
                <v-list-tile-action>
                  <v-switch color="grey" v-model="states" :value="1"></v-switch>
                </v-list-tile-action>
                <v-list-tile-title>Todo</v-list-tile-title>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-action>
                  <v-switch color="blue" v-model="states" :value="2"></v-switch>
                </v-list-tile-action>
                <v-list-tile-title>Doing</v-list-tile-title>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-action>
                  <v-switch color="green" v-model="states" :value="3"></v-switch>
                </v-list-tile-action>
                <v-list-tile-title>Done</v-list-tile-title>
              </v-list-tile>
              <v-list-tile>
                <v-list-tile-action>
                  <v-switch color="error" v-model="states" :value="4"></v-switch>
                </v-list-tile-action>
                <v-list-tile-title>Error</v-list-tile-title>
              </v-list-tile>
            </v-list>
          </v-card>
        </v-menu>
      </v-toolbar>
      <v-list two-line>
        <v-list-tile v-if="loader.loading">
          <v-list-tile-content>
            <v-container class="text-xs-center">
              <v-progress-circular indeterminate color="primary"></v-progress-circular>
            </v-container>
          </v-list-tile-content>
        </v-list-tile>
        <v-list-tile v-if="loader.finished && !loader.items.length">
          <v-list-tile-content>
            <span>No source found with those filters.</span>
          </v-list-tile-content>
        </v-list-tile>
        <template v-for="(source, index) in loader.items">
          <v-list-tile :key="source.id">
            <v-list-tile-content>
              <v-list-tile-title><a :href="source.source_url" target="_blank">{{ source.source_url }}</a></v-list-tile-title>
              <v-list-tile-sub-title class="text--primary">
                <span>{{ source.author.username }}</span>
              </v-list-tile-sub-title>
              <v-list-tile-sub-title
                v-if="source.error"
                class="red--text"
              >{{ source.error }}</v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-list-tile-action-text>{{ source.recipes }} recipe(s)</v-list-tile-action-text>
              <v-icon
                class="state-todo"
                v-if="source.state === 1"
              >access_time</v-icon>
              <v-progress-circular
                size="24"
                class="state-doing"
                indeterminate
                v-if="source.state === 2"
              ></v-progress-circular>
              <v-icon
                class="state-done"
                v-if="source.state === 3"
              >done</v-icon>
              <v-icon
                class="state-error"
                v-if="source.state === 4"
                v-on:dblclick="retry(source, index)"
              >error</v-icon>
            </v-list-tile-action>
          </v-list-tile>
          <v-divider
            v-if="index + 1 < loader.items.length"
            :key="index"
          ></v-divider>
        </template>
      </v-list>
    </v-card>
  </v-container>
</template>

<script>
  import InfiniteLoader from '@/utils/infinite-loader'

  export default {
    data () {
      return {
        states: [0, 1, 2, 3, 4],
        loader: new InfiniteLoader(this.$api.sources.get, 40, {state: [1, 2, 3, 4].join(',')}),
      }
    },
    watch: {
      states(value) {
        this.loader.setFilters({'state': value.join(',')})
        this.load()
      }
    },
    methods: {
      load() {
        this.loader.load().then(() => {
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.dispatch('alert/error', 'Unable to load list of sources')
        })
      },
      refresh() {
        this.loader.reset()
        this.load()
      },
      retry(source) {
        this.$confirm('Are you sure to reset this source?').then(choice => {
          if(choice) {
            this.$api.sources.retry({id: source.id}, {}).then(() => {
              this.loader.reset()
              this.load()
            }, () => {
              this.$store.dispatch('alert/error', 'Error while resetting source\'s state')
            })
          }
        })
      },
      scroll() {
        window.onscroll = () => {
          let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.offsetHeight;

          if (bottomOfWindow) {
            this.load()
          }
        }
      }
    },
    mounted: function() {
      this.load()
      this.scroll()
    }
  }
</script>

<style lang="scss" scoped>
  .state-doing {
    color: blue !important;
  }

  .state-done {
    color: green !important;
  }

  .state-error {
    color: red !important;
    cursor: pointer;
  }
</style>
