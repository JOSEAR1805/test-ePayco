<template>
  <a-row>
    <a-col :span="24">
      <a-breadcrumb>
        <a-breadcrumb-item>
          <a href="/">
            <a-icon type="home" />
          </a>
        </a-breadcrumb-item>
        <a-breadcrumb-item>Billetera</a-breadcrumb-item>
        <a-breadcrumb-item>Saldo</a-breadcrumb-item>
      </a-breadcrumb>

      <a-page-header
        style="border-bottom: 1px solid rgb(235, 237, 240); margin-bottom: 16px"
        title="Consulta de Saldo"
      />

      <a-form :form="form" @submit="handleSubmit">
        <a-row :gutter="[16,16]" type="flex" justify="space-around">
          
          <a-col :span="6">
            <a-form-item label="Documento">
              <a-input
                v-decorator="[
                  'document',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>
          
          <a-col :span="6">
            <a-form-item label="Teléfono">
              <a-input
                v-decorator="[
                  'phone',
                  {
                    rules: [messageRequired],
                  },
                ]"
              />
            </a-form-item>
          </a-col>

        </a-row>
        <a-row style="text-align: center;">
            <a-button type="primary" html-type="submit"> Consultar </a-button>
        </a-row>

        <a-row v-if=consult>
          <a-divider orientation="right">
            Consulta de Usuario
          </a-divider>
          <a-descriptions >
            <a-descriptions-item label="Nombre">
              {{ dataUser.name }}
            </a-descriptions-item>
            <a-descriptions-item label="Saldo Disponible">
              {{ dataUser.total }}
            </a-descriptions-item>
          </a-descriptions>
       
          <a-table :columns="columns" :data-source="dataBalance">
            <span slot="type" slot-scope="text">
              <a-tag :color="text === '1' ? 'green' : 'red'">
                {{ text === "1"? "Ingreso": "Egreso" }}
              </a-tag>
            </span>
          </a-table>
        </a-row>

      </a-form>
    </a-col>
  </a-row>
</template>

<script>

const columns = [
  {
    title: 'Tipo de balance',
    dataIndex: 'type',
    key: 'id',
    scopedSlots: { customRender: 'type' },
  },
  {
    title: 'Fecha',
    dataIndex: 'updatedAt',
    key: 'updatedAt'
  },
  {
    title: 'Monto',
    dataIndex: 'quantity',
    key: 'createdAt',
    width: 80,
  }
];

export default {
  data() {
    return {
      consult: false,
      dataUser: null,
      columns,
      dataBalance: [],
      messageRequired: { 
        required: true, 
        message: 'Campo requerido!' 
      },
      form: this.$form.createForm(this, { name: 'coordinated' }),
    }
  },
  methods: {
    openNotification(resp, type) {
      this.$notification[type]({
        message: type === "success" ? "¡ÉXITO!" : type === "error" ? "¡ALERTA!" : "¡ATENCIÓN!" ,
        description: type === "error" ? "Hubo un error al comunicar con el servidor." : resp ,
        placement: 'bottomRight',
      });
    },
    async handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) { this.rechargue = values; } 
        else { this.rechargue = false }
      });

      if (this.rechargue) { 
        const response = await this.$axios.$post('http://local-epayco/resttransaction/consultBalance', this.rechargue)
        try {
          if (response.code === 500) {
            this.openNotification(response.message, "warning");
          }

          let ingreso = 0;
          let egreso = 0;

          response.data.map((item) => {
            if (item.type === "1") {
              ingreso = ingreso + parseFloat(item.quantity);
            } else {
              egreso = egreso + parseFloat(item.quantity);
            }
          })

          response.user.total = (ingreso - egreso).toFixed(2);

          this.consult = true
          this.dataBalance = response.data;
          this.dataUser = response.user;
         
        } catch (error) {
          this.openNotification(error, "error");
        }
      }
    },
  },
}
</script>