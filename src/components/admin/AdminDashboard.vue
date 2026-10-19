<script setup lang="ts">
import { computed, ref, onMounted } from 'vue';
import DatePicker from 'primevue/datepicker';
import DataTable from 'primevue/datatable';
import Column from 'primevue/column';
import InputText from 'primevue/inputtext';
import Card from 'primevue/card';
import Chart from 'primevue/chart';
import Button from 'primevue/button';
import Tag from 'primevue/tag';

import stats from '../../data/mock/stats.json';
import customers from '../../data/mock/customers.json';

const scheduleDate = ref<Date | null>(new Date());
const search = ref('');

const filteredCustomers = computed(() => {
  if (!search.value.trim()) {
    return customers;
  }

  const query = search.value.toLowerCase();
  return customers.filter((customer) => {
    return [customer.name, customer.email, customer.plan, customer.status].some((field) =>
      field.toLowerCase().includes(query)
    );
  });
});

const chartData = ref();
const chartOptions = ref();

onMounted(() => {
    chartData.value = {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [
            {
                label: 'Revenue',
                data: [6500, 5900, 8000, 8100, 5600, 5500, 4000],
                fill: true,
                borderColor: '#FF4D00',
                backgroundColor: 'rgba(255, 77, 0, 0.1)',
                tension: 0.4
            },
            {
                label: 'Sessions',
                data: [28, 48, 40, 19, 86, 27, 90],
                fill: true,
                borderColor: '#0057FF',
                backgroundColor: 'rgba(0, 87, 255, 0.1)',
                tension: 0.4,
                yAxisID: 'y1'
            }
        ]
    };

    chartOptions.value = {
        stacked: false,
        maintainAspectRatio: false,
        aspectRatio: 0.6,
        plugins: {
            legend: {
                labels: {
                    color: '#64748b'
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: '#64748b'
                },
                grid: {
                    color: '#e2e8f0'
                }
            },
            y: {
                type: 'linear',
                display: true,
                position: 'left',
                ticks: {
                    color: '#64748b'
                },
                grid: {
                    color: '#e2e8f0'
                }
            },
            y1: {
                type: 'linear',
                display: true,
                position: 'right',
                grid: {
                    drawOnChartArea: false,
                    color: '#e2e8f0'
                },
                ticks: {
                    color: '#64748b'
                }
            }
        }
    };
});

const getSeverity = (status: string) => {
    const statuses: Record<string, string> = {
        'Active': 'success',
        'Inactive': 'danger',
        'Pending': 'warn'
    };
    return statuses[status] || 'info';
};
</script>

<template>
  <div class="grid gap-6 p-4">
    <!-- Stats Row -->
    <section class="grid gap-4 md:grid-cols-3">
      <Card class="shadow-sm border border-slate-200">
        <template #title>
            <div class="text-sm font-medium uppercase text-slate-500 tracking-wider">Μηνιαίο Έσοδο</div>
        </template>
        <template #content>
            <div class="flex items-baseline space-x-2">
                 <span class="text-3xl font-bold font-mono text-slate-800">€{{ stats.revenue }}</span>
            </div>
            <div class="text-green-600 text-sm font-medium mt-2 flex items-center">
                <i class="pi pi-arrow-up mr-1 text-xs"></i> 12% ανάπτυξη
            </div>
        </template>
      </Card>
      
      <Card class="shadow-sm border border-slate-200">
        <template #title>
             <div class="text-sm font-medium uppercase text-slate-500 tracking-wider">Ενεργοί Χρήστες</div>
        </template>
        <template #content>
             <div class="flex items-baseline space-x-2">
                 <span class="text-3xl font-bold font-mono text-slate-800">{{ stats.activeUsers }}</span>
            </div>
             <div class="text-blue-600 text-sm font-medium mt-2 flex items-center">
                +4 νέες εγγραφές
            </div>
        </template>
      </Card>

      <Card class="shadow-sm border border-slate-200">
        <template #title>
             <div class="text-sm font-medium uppercase text-slate-500 tracking-wider">Πληρότητα</div>
        </template>
        <template #content>
             <div class="flex items-baseline space-x-2">
                 <span class="text-3xl font-bold font-mono text-slate-800">{{ stats.occupancy }}%</span>
            </div>
             <div class="text-orange-600 text-sm font-medium mt-2 flex items-center">
                2 θέσεις διαθέσιμες απόψε
            </div>
        </template>
      </Card>
    </section>

    <!-- Main Content Area -->
    <section class="grid gap-6 lg:grid-cols-[2fr_1fr]">
      <!-- Customers Table -->
      <div class="flex flex-col gap-6">
        <Card class="shadow-sm border border-slate-200 h-full">
            <template #title>
                <div class="flex items-center justify-between mb-2">
                    <span class="text-xl font-bold text-slate-800">Πελάτες</span>
                    <span class="relative">
                        <InputText v-model="search" placeholder="Αναζήτηση..." class="p-inputtext-sm" />
                    </span>
                </div>
            </template>
            <template #content>
                 <DataTable :value="filteredCustomers" paginator :rows="5" :rowsPerPageOptions="[5, 10, 20]" tableStyle="min-width: 100%">
                    <Column field="name" header="Όνομα" sortable>
                        <template #body="{ data }">
                            <span class="font-medium text-slate-700">{{ data.name }}</span>
                        </template>
                    </Column>
                    <Column field="email" header="Email" sortable></Column>
                    <Column field="plan" header="Πρόγραμμα" sortable>
                         <template #body="{ data }">
                            <Tag :value="data.plan" severity="info" rounded class="!bg-slate-100 !text-slate-700 !border-slate-200 border" />
                        </template>
                    </Column>
                    <Column field="status" header="Κατάσταση" sortable>
                        <template #body="{ data }">
                            <Tag :value="data.status" :severity="getSeverity(data.status)" rounded />
                        </template>
                    </Column>
                </DataTable>
            </template>
        </Card>
        
        <!-- Chart -->
        <Card class="shadow-sm border border-slate-200">
            <template #title>
                <div class="text-xl font-bold text-slate-800 mb-4">Στατιστικά Απόδοσης</div>
            </template>
            <template #content>
               <div class="h-[350px]">
                   <Chart type="line" :data="chartData" :options="chartOptions" class="h-full" />
               </div>
            </template>
        </Card>
      </div>

      <!-- Schedule -->
      <div class="flex flex-col gap-6">
         <Card class="shadow-sm border border-slate-200">
            <template #title>
                 <div class="text-xl font-bold text-slate-800 mb-4">Ημερολόγιο</div>
            </template>
            <template #content>
                <DatePicker v-model="scheduleDate" inline showWeek class="w-full !border-0" />
            </template>
        </Card>

        <Card class="shadow-sm border border-slate-200">
             <template #title>
                 <div class="text-xl font-bold text-slate-800 mb-4">Πρόγραμμα Σήμερα</div>
            </template>
            <template #content>
                <ul class="space-y-4">
                    <li class="flex items-center gap-3 border-b border-slate-100 pb-3">
                        <div class="w-3 h-3 rounded-full bg-green-500 shadow-sm"></div>
                        <div class="flex-1">
                            <div class="font-bold text-slate-800">Γιώργος Παπαδόπουλος</div>
                            <div class="text-xs font-semibold text-slate-500 uppercase tracking-wide">09:00 - 10:00</div>
                            <div class="text-xs text-slate-400 mt-1">Προπόνηση Δύναμης</div>
                        </div>
                    </li>
                     <li class="flex items-center gap-3 border-b border-slate-100 pb-3">
                        <div class="w-3 h-3 rounded-full bg-orange-500 shadow-sm"></div>
                        <div class="flex-1">
                            <div class="font-bold text-slate-800">Μαρία Κωνσταντίνου</div>
                            <div class="text-xs font-semibold text-slate-500 uppercase tracking-wide">10:30 - 11:30</div>
                            <div class="text-xs text-slate-400 mt-1">Αποκατάσταση</div>
                        </div>
                    </li>
                     <li class="flex items-center gap-3 pb-2">
                        <div class="w-3 h-3 rounded-full bg-blue-500 shadow-sm"></div>
                        <div class="flex-1">
                            <div class="font-bold text-slate-800">Κώστας Δημητρίου</div>
                            <div class="text-xs font-semibold text-slate-500 uppercase tracking-wide">18:00 - 19:00</div>
                            <div class="text-xs text-slate-400 mt-1">Λιποδιάλυση</div>
                        </div>
                    </li>
                </ul>
                <div class="mt-4 pt-4 border-t border-slate-100">
                    <Button label="Δες Όλο το Πρόγραμμα" size="small" variant="outlined" class="w-full" />
                </div>
            </template>
        </Card>
      </div>
    </section>
  </div>
</template>
