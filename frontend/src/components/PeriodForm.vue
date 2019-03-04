<template>
  <v-card>
    <v-card-title>
      <span class="headline">Period</span>
    </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-layout wrap>
          <v-flex xs12>
            <v-menu
              v-model="start_date"
              :close-on-content-click="false"
              :nudge-right="40"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  v-model="instance.start_date"
                  label="Start date"
                  prepend-icon="event"
                  readonly
                  v-on="on"
                  v-validate="'required'"
                  :error-messages="errors.collect('start_date')"
                  data-vv-name="start_date"
                  required
                ></v-text-field>
              </template>
              <v-date-picker v-model="instance.start_date" @input="start_date = false"></v-date-picker>
            </v-menu>
          </v-flex>
          <v-flex xs12>
            <v-menu
              v-model="end_date"
              :close-on-content-click="false"
              :nudge-right="40"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  v-model="instance.end_date"
                  label="End date"
                  prepend-icon="event"
                  readonly
                  v-on="on"
                  v-validate="'required'"
                  :error-messages="errors.collect('end_date')"
                  data-vv-name="end_date"
                  required
                ></v-text-field>
              </template>
              <v-date-picker v-model="instance.end_date" @input="end_date = false"></v-date-picker>
            </v-menu>
          </v-flex>
        </v-layout>
      </v-container>
      <small>*indicates required field</small>
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="blue darken-1" flat @click="$emit('cancel')">Cancel</v-btn>
      <v-btn color="blue darken-1" flat @click="save()">Save</v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
  export default {
    data () {
      return {
        start_date: false,
        end_date: false,
      }
    },
    props: {
      instance: Object,
    },
    watch: {
      instance () {
        this.$validator.reset()
      }
    },
    mounted () {
      this.$validator.localize('en')
    },
    methods: {
      save() {
        this.$validator.validateAll().then(result => {
          if(result) {
            let func;
            let filters;

            if(this.instance.id) {
              func = this.$api.periods.update
              filters = {id : this.instance.id}
            } else {
              func = this.$api.periods.save
              filters = {}
            }

            func(filters, this.instance).then(response => {
              this.$emit('save', response.body)
            }, response => {
              for(let field in response.body) {
                response.body[field].forEach(msg => {
                  this.$validator.errors.add({ field, msg })
                })
              }
            })
          }
        })
      }
    }
  }
</script>
