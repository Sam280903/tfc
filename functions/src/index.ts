import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Inicializa o admin do Firebase para ter acesso aos serviços
admin.initializeApp();

// Define a região para as funções. "southamerica-east1" é São Paulo.
const region = "southamerica-east1";

/**
 * Gatilho (trigger) que é acionado sempre que um novo documento
 * é criado na coleção 'agendamentos'.
 */
export const notificarNovoAgendamento = functions
  .region(region)
  .firestore.document("agendamentos/{agendamentoId}")
  .onCreate(async (snapshot) => {
    // Pega os dados do agendamento que acabou de ser criado.
    const agendamento = snapshot.data();

    if (!agendamento) {
      console.log("Nenhum dado encontrado no agendamento. A função será encerrada.");
      return;
    }

    const idTecnico = agendamento.idTecnico;
    const idCliente = agendamento.idCliente;

    // --- 1. Buscar os tokens de notificação do técnico ---
    const tokensSnapshot = await admin
      .firestore()
      .collection("usuarios")
      .doc(idTecnico)
      .collection("tokens")
      .get();

    if (tokensSnapshot.empty) {
      console.log(`O técnico ${idTecnico} não possui tokens de notificação.`);
      return;
    }
    const tokens = tokensSnapshot.docs.map((doc) => doc.id);

    // --- 2. Buscar o nome do cliente para a mensagem ---
    const clienteDoc = await admin
      .firestore()
      .collection("clientes")
      .doc(idCliente)
      .get();
    const nomeCliente = clienteDoc.data()?.nome || "Cliente não identificado";

    // --- 3. Montar a mensagem da notificação ---
    const payload = {
      notification: {
        title: "Novo Agendamento!",
        body: `Você tem um novo atendimento para o cliente: ${nomeCliente}. Verifique a sua agenda.`,
        sound: "default",
      },
      data: {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "agendamentoId": snapshot.id,
      },
    };

    // --- 4. Enviar a notificação para todos os dispositivos do técnico ---
    console.log(`Enviando notificação sobre o cliente ${nomeCliente} para os tokens: ${tokens}`);
    return admin.messaging().sendToDevice(tokens, payload);
  });