//
//  MessageQueue.cpp
//  MessageHandler
//
//  Created by Hrach Ayunts on 29.03.21.
//

#include "MessageQueue.hpp"
#include <string>
#include <mutex>
#include <thread>
#include <condition_variable>

void callHandlers(MessageQueue* mq) {
    while (true) {
        mq->cv.wait(mq->m);
        std::string m = mq->messages.front();
        mq->messages.pop();
        mq->m.unlock();
    }
}

MessageQueue::MessageQueue():
t(callHandlers, this) {

}

void MessageQueue::AddMessage(std::string message) {
    m.lock();
    messages.push(message);
    cv.notify_one();
    m.unlock();
}

void MessageQueue::RegisterHandler(MessageHandler handler) {
    handlers.insert(handler);
}
