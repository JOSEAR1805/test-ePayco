<template>
  <a-row>
    <a-col :span="24">
      <a-breadcrumb>
        <a-breadcrumb-item>
          <a href="/">
            <a-icon type="home" />
          </a>
        </a-breadcrumb-item>
        <a-breadcrumb-item>Clientes</a-breadcrumb-item>
      </a-breadcrumb>

      <a-page-header
        style="border-bottom: 1px solid rgb(235, 237, 240); margin-bottom: 16px"
        title="Listado de Clientes"
      >
        <template slot="extra">
          <a-button key="1" type="primary">
            <NuxtLink to="clients/add"> Registrar </NuxtLink>
          </a-button>
        </template>
      </a-page-header>

      <a-table :data-source="data" :columns="columns">
        <div
          slot="filterDropdown"
          slot-scope="{
            setSelectedKeys,
            selectedKeys,
            confirm,
            clearFilters,
            column,
          }"
          style="padding: 8px"
        >
          <a-input
            v-ant-ref="(c) => (searchInput = c)"
            :placeholder="`Search ${column.dataIndex}`"
            :value="selectedKeys[0]"
            style="width: 188px; margin-bottom: 8px; display: block"
            @change="
              (e) => setSelectedKeys(e.target.value ? [e.target.value] : [])
            "
            @pressEnter="
              () => handleSearch(selectedKeys, confirm, column.dataIndex)
            "
          />
          <a-button
            type="primary"
            icon="search"
            size="small"
            style="width: 90px; margin-right: 8px"
            @click="() => handleSearch(selectedKeys, confirm, column.dataIndex)"
          >
            Search
          </a-button>
          <a-button
            size="small"
            style="width: 90px"
            @click="() => handleReset(clearFilters)"
          >
            Reset
          </a-button>
        </div>
        <a-icon
          slot="filterIcon"
          slot-scope="filtered"
          type="search"
          :style="{ color: filtered ? '#108ee9' : undefined }"
        />
        <template slot="customRender" slot-scope="text, record, index, column">
          <span v-if="searchText && searchedColumn === column.dataIndex">
            <template
              v-for="(fragment, i) in text
                .toString()
                .split(new RegExp(`(?<=${searchText})|(?=${searchText})`, 'i'))"
            >
              <mark
                v-if="fragment.toLowerCase() === searchText.toLowerCase()"
                :key="i"
                class="highlight"
                >{{ fragment }}</mark
              >
              <template v-else>{{ fragment }}</template>
            </template>
          </span>
          <template v-else>
            {{ text }}
          </template>
        </template>
      </a-table>
    </a-col>
  </a-row>
</template>

<script>

export default {
  data() {
    return {
      data: [],
      searchText: '',
      searchInput: null,
      searchedColumn: '',
      columns: [
        {
          title: 'Nombre',
          dataIndex: 'name',
          key: 'name',
          scopedSlots: {
            filterDropdown: 'filterDropdown',
            filterIcon: 'filterIcon',
            customRender: 'customRender',
          },
          onFilter: (value, record) =>
            record.name.toString().toLowerCase().includes(value.toLowerCase()),
          onFilterDropdownVisibleChange: (visible) => {
            if (visible) {
              setTimeout(() => {
                this.searchInput.focus()
              }, 0)
            }
          },
        },
        {
          title: 'Documento',
          dataIndex: 'document',
          key: 'document',
          scopedSlots: {
            filterDropdown: 'filterDropdown',
            filterIcon: 'filterIcon',
            customRender: 'customRender',
          },
          onFilter: (value, record) =>
            record.document
              .toString()
              .toLowerCase()
              .includes(value.toLowerCase()),
          onFilterDropdownVisibleChange: (visible) => {
            if (visible) {
              setTimeout(() => {
                this.searchInput.focus()
              })
            }
          },
        },
        {
          title: 'Correo',
          dataIndex: 'email',
          key: 'email',
          scopedSlots: {
            filterDropdown: 'filterDropdown',
            filterIcon: 'filterIcon',
            customRender: 'customRender',
          },
          onFilter: (value, record) =>
            record.email.toString().toLowerCase().includes(value.toLowerCase()),
          onFilterDropdownVisibleChange: (visible) => {
            if (visible) {
              setTimeout(() => {
                this.searchInput.focus()
              })
            }
          },
        },
        {
          title: 'Teléfono',
          dataIndex: 'phone',
          key: 'phone',
          scopedSlots: {
            filterDropdown: 'filterDropdown',
            filterIcon: 'filterIcon',
            customRender: 'customRender',
          },
          onFilter: (value, record) =>
            record.phone.toString().toLowerCase().includes(value.toLowerCase()),
          onFilterDropdownVisibleChange: (visible) => {
            if (visible) {
              setTimeout(() => {
                this.searchInput.focus()
              })
            }
          },
        },
      ],
    }
  },
  async created() {
    await this.getAll()
  },
  methods: {
    handleSearch(selectedKeys, confirm, dataIndex) {
      confirm()
      this.searchText = selectedKeys[0]
      this.searchedColumn = dataIndex
    },

    handleReset(clearFilters) {
      clearFilters()
      this.searchText = ''
    },

    async getAll() {
      const response = await this.$axios.$get(
        'http://local-epayco/restuser'
      )
      if (response.data.length > 0) {
        response.data.map((resp, key) => {
          resp.key = key+1;
        })
        this.data = response.data
      }
    },
  },
}
</script>

<style scoped>
.highlight {
  background-color: rgb(255, 192, 105);
  padding: 0px;
}
</style>
