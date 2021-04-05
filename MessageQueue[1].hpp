//
//  MessageQueue.hpp
//  MessageHandler
//
//  Created by Hrach Ayunts on 29.03.21.
//

#ifndef MessageQueue_hpp
#define MessageQueue_hpp

#include <stdio.h>
#include <queue>
#include <set>
#include <mutex>
#include <thread>

typedef void (*MessageHandler)(std::string message);

class MessageQueue {
public:
    MessageQueue();
    void AddMessage(std::string message);
    void RegisterHandler(MessageHandler handler);
private:
    std::queue<std::string> messages;
    std::set<MessageHandler> handlers;
    std::unique_lock<std::mutex> m;
    std::thread t;
    std::condition_variable cv;
    
    friend void callHandlers(MessageQueue* mq);
};

#endif /* MessageQueue_hpp */
