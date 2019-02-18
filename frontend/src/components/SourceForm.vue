<template>
  <v-card>
    <v-card-title>
      <span class="headline">Recipe source</span>
    </v-card-title>
    <v-card-text>
      <v-container grid-list-md>
        <v-layout wrap>
          <v-flex xs12>
            <v-text-field
              label="Source URL*"
              v-model="instance.source_url"
              v-validate="'required|url'"
              :error-messages="errors.collect('source_url')"
              data-vv-name="source_url"
              required
            ></v-text-field>
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
            this.$api.sources.save({}, this.instance).then(response => {
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
