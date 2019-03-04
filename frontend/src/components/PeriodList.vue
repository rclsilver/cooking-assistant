<template>
  <v-container>
    <v-dialog v-model="formDialog" persistent max-width="600px">
      <period-form :instance="periodInstance" v-on:cancel="onFormCancel()" v-on:save="onFormSave($event)" />
    </v-dialog>
    <v-card>
      <v-toolbar>
        <span class="headline">Periods</span>
        <v-spacer></v-spacer>
        <v-btn icon @click.prevent.stop="showForm({})" title="Create period">
          <v-icon>add</v-icon>
        </v-btn>
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
                  <v-switch v-model="showPastPeriods"></v-switch>
                </v-list-tile-action>
                <v-list-tile-title>Past periods</v-list-tile-title>
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
            <span>No period found.</span>
          </v-list-tile-content>
        </v-list-tile>
        <template v-for="(period, index) in loader.items">
          <v-list-tile :key="period.id">
            <v-list-tile-content>
              <v-list-tile-title>From {{ period.start_date }} to {{ period.end_date }}</v-list-tile-title>
              <v-list-tile-sub-title class="text--primary">
                <span>{{ period.author.username }}</span>
              </v-list-tile-sub-title>
            </v-list-tile-content>
            <v-list-tile-action>
              <v-list-tile-action-text>{{ period.recipes }} recipe(s)</v-list-tile-action-text>
              <v-menu
                bottom
                left
                offset-x
                offset-y
              >
                <v-btn slot="activator" icon title="Actions">
                  <v-icon>more_vert</v-icon>
                </v-btn>
                <v-card>
                  <v-list>
                    <v-list-tile @click="showForm(period)">
                      <v-list-tile-action>
                        <v-icon>edit</v-icon>
                      </v-list-tile-action>
                      <v-list-tile-content>
                        <v-list-tile-title>Edit</v-list-tile-title>
                      </v-list-tile-content>
                    </v-list-tile>
                    <v-list-tile @click="deletePeriod(period)">
                      <v-list-tile-action>
                        <v-icon>delete</v-icon>
                      </v-list-tile-action>
                      <v-list-tile-content>
                        <v-list-tile-title>Delete</v-list-tile-title>
                      </v-list-tile-content>
                    </v-list-tile>
                  </v-list>
                </v-card>
              </v-menu>
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
  import PeriodForm from '@/components/PeriodForm'

  export default {
    components: {
      PeriodForm,
    },
    data () {
      return {
        showPastPeriods: false,
        loader: new InfiniteLoader(this.$api.periods.get, 40, {'past': this.showPastPeriods}),
        periodInstance: {},
        formDialog: false,
      }
    },
    watch: {
      showPastPeriods(value) {
        this.loader.setFilters({'past': value})
        this.load()
      }
    },
    methods: {
      load() {
        this.loader.load().then(() => {
          this.$store.dispatch('alert/clear')
        }, () => {
          this.$store.dispatch('alert/error', 'Unable to load list of periods')
        })
      },
      refresh() {
        this.loader.reset()
        this.load()
      },
      scroll() {
        window.onscroll = () => {
          let bottomOfWindow = document.documentElement.scrollTop + window.innerHeight === document.documentElement.offsetHeight;

          if (bottomOfWindow) {
            this.load()
          }
        }
      },
      showForm(instance) {
        this.periodInstance = instance
        this.formDialog = true
      },
      onFormCancel() {
        this.periodInstance = {}
        this.formDialog = false
      },
      onFormSave() {
        this.onFormCancel()
        this.refresh()
      },
      deletePeriod(instance) {
        this.$confirm('Are you sure to delete this period?').then(choice => {
          if(choice) {
            this.$api.periods.delete({id: instance.id}, {}).then(() => {
              this.loader.reset()
              this.load()
            }, () => {
              this.$store.dispatch('alert/error', 'Error while deleting period')
            })
          }
        })
      }
    },
    mounted: function() {
      this.load()
      this.scroll()
    }
  }
</script>
