<script setup lang="ts">
import { ref, computed } from 'vue';
import DatePicker from 'primevue/datepicker';
import Button from 'primevue/button';
import InputText from 'primevue/inputtext';
import Select from 'primevue/select';
import Card from 'primevue/card';

// --- State ---
const step = ref(2); // Start at Calendar
const selectedService = ref({ id: 'default', title: 'Personal Training Session' }); // Default service
const selectedDate = ref<Date | null>(new Date()); // Default to today
const selectedTime = ref<string | null>(null);
const userDetails = ref({
  name: 'Γιάννης Παπαδόπουλος', // Mock Logged In User
  email: 'giannis@example.com',
  notes: ''
});
const isSubmitting = ref(false);

// --- Data ---
// Services removed from selection flow but kept for reference if needed
const timeSlots = [
  '09:00', '10:00', '11:00', '12:00', 
  '14:00', '15:00', '16:00', '17:00', '18:00', '19:00'
];

// --- Computed ---
const isDateSelected = computed(() => !!selectedDate.value);
const isTimeSelected = computed(() => !!selectedTime.value);

// --- Methods ---
const formatDate = (date: Date) => {
  return new Intl.DateTimeFormat('el-GR', { weekday: 'long', day: 'numeric', month: 'long' }).format(date);
};

const submitBooking = async () => {
  if (!selectedDate.value || !selectedTime.value) return;
  
  isSubmitting.value = true;
  // Simulate API
  await new Promise(resolve => setTimeout(resolve, 1500));
  step.value = 4; // Success
  isSubmitting.value = false;
};
</script>

<template>
  <div class="w-full max-w-4xl mx-auto p-4 md:p-6">
    

    <!-- Step 2: Calendar & Time (Now the Main View) -->
    <div v-if="step === 2" class="animate-fade-in w-full">
       <div class="flex flex-col items-center mb-8">
          <h2 class="text-3xl lg:text-4xl font-bold text-center tracking-tight text-zinc-700">Προγραμμάτισε τη Συνεδρία σου</h2>
          <p class="text-zinc-500 text-center mt-2 max-w-md">Επίλεξε την ημέρα και την ώρα που σε εξυπηρετεί.</p>
       </div>

       <div class="flex flex-col lg:flex-row gap-8 lg:gap-12 items-start justify-center max-w-6xl mx-auto">
          <!-- Calendar -->
          <div class="w-full lg:flex-1 bg-white p-6 rounded-3xl border border-zinc-100 shadow-xl shadow-zinc-200/50">
             <DatePicker 
                v-model="selectedDate"
                inline 
                class="w-full"
                :pt="{
                    root: { class: 'w-full' },
                    panel: { class: 'border-0 p-0 w-full' },
                    header: { class: 'bg-transparent border-0 pt-0 pb-6 text-zinc-600' },
                    table: { class: 'w-full border-collapse' },
                    tableHeaderCell: { class: 'p-0 pb-4 text-xs font-bold text-zinc-400 uppercase tracking-widest' },
                    dayCell: { class: 'p-1' },
                    day: { class: 'w-10 h-10 md:w-14 md:h-14 text-sm md:text-lg font-medium rounded-2xl text-zinc-600 hover:bg-zinc-50 transition-all duration-300 data-[p-selected=true]:bg-swiss-orange data-[p-selected=true]:text-white focus:shadow-none' }
                }"
             />
          </div>

          <!-- Time Slots & Confirm (Combined) -->
          <div class="w-full lg:w-96 animate-fade-in-up flex flex-col gap-6" v-if="selectedDate">
             <div class="bg-white p-6 rounded-3xl border border-zinc-100 shadow-lg shadow-zinc-200/50">
                 <div class="flex items-center justify-between mb-6">
                    <h3 class="text-lg font-bold text-zinc-700">Διαθέσιμες Ώρες</h3>
                    <span class="text-xs font-bold bg-zinc-100 px-3 py-1 rounded-full text-zinc-500 uppercase">{{ formatDate(selectedDate) }}</span>
                 </div>
                 
                 <div class="grid grid-cols-3 gap-3 mb-6">
                    <button 
                      v-for="time in timeSlots" 
                      :key="time"
                      @click="selectedTime = time"
                      class="py-3 rounded-xl text-sm font-bold transition-all duration-300 border-2"
                      :class="[
                        selectedTime === time 
                          ? 'border-swiss-orange bg-swiss-orange text-white transform scale-105 shadow-md shadow-orange-200' 
                          : 'border-transparent bg-zinc-50 text-zinc-600 hover:bg-zinc-100 hover:border-zinc-200'
                      ]"
                    >
                      {{ time }}
                    </button>
                 </div>

                 <!-- Confirmed User Info (Implicit) -->
                 <div class="border-t border-zinc-100 pt-6 mb-6">
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-10 h-10 rounded-full bg-zinc-100 flex items-center justify-center text-lg">👤</div>
                        <div>
                            <p class="text-xs text-zinc-500 font-bold uppercase">Κρατηση ως</p>
                            <p class="text-sm font-bold text-zinc-900">{{ userDetails.name }}</p>
                        </div>
                    </div>
                 </div>
                 
                 <Button 
                   label="Επιβεβαίωση Κράτησης" 
                   :loading="isSubmitting"
                   :disabled="!isTimeSelected"
                   @click="submitBooking"
                   class="w-full font-bold !rounded-xl !py-3 !text-lg shadow-lg shadow-swiss-orange/20" 
                 />
             </div>
          </div>
          
          <div v-else class="w-full lg:w-96 p-12 text-zinc-300 border-2 border-dashed border-zinc-200 rounded-3xl flex flex-col items-center justify-center text-center">
             <span class="text-5xl mb-4 opacity-50">📅</span>
             <p class="font-medium">Διάλεξε ημερομηνία για να εμφανιστούν οι ώρες.</p>
          </div>
       </div>
    </div>

    <!-- Step 4: Success -->
    <div v-if="step === 4" class="flex flex-col items-center justify-center py-12 animate-fade-in text-center">
       <div class="w-20 h-20 bg-green-100 text-green-600 rounded-full flex items-center justify-center text-4xl mb-6">
          ✓
       </div>
       <h2 class="text-3xl font-bold text-zinc-900 mb-4">Η Κράτηση Ολοκληρώθηκε!</h2>
       <p class="text-zinc-500 max-w-md mb-8">
         Θα λάβεις σύντομα ένα email επιβεβαίωσης στο <strong>{{ userDetails.email }}</strong>. Ανυπομονούμε να σε δούμε!
       </p>
       <a href="/" class="text-swiss-orange font-bold hover:underline">Επιστροφή στην Αρχική</a>
    </div>

  </div>
</template>

<style scoped>
.animate-fade-in {
  animation: fadeIn 0.4s ease-out forwards;
}

.animate-fade-in-up {
  animation: fadeInUp 0.4s ease-out forwards;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

/* Custom adjustments for PrimeVue DatePicker responsiveness if PT isn't enough */
:deep(.p-datepicker) {
  border: none;
  background: transparent;
}
:deep(.p-datepicker-header) {
  padding-bottom: 1rem;
}
/* Ensure cells are square-ish and touch friendly */
:deep(.p-datepicker table td > span) {
    width: 2.5rem;
    height: 2.5rem;
    line-height: 2.5rem;
}
@media (max-width: 640px) {
    :deep(.p-datepicker table td > span) {
        width: 2rem;
        height: 2rem;
        line-height: 2rem;
        font-size: 0.875rem;
    }
}
</style>
