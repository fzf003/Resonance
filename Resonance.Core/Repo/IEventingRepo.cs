﻿using Resonance.Repo.InternalModels;
using Resonance.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Resonance.Repo
{
    public interface IEventingRepo : IDisposable
    {
        // Transaction Management
        /// <summary>
        /// Starts a new transaction
        /// </summary>
        void BeginTransaction();
        void RollbackTransaction();
        void CommitTransaction();

        // Topic & subscription management
        IEnumerable<Topic> GetTopics(string partOfName = null);
        Topic GetTopic(string id);
        Topic GetTopicByName(string name);
        Topic AddOrUpdateTopic(Topic topic);
        void DeleteTopic(string id, bool inclSubscriptions);
        IEnumerable<Subscription> GetSubscriptions(string topicId = null);
        Subscription GetSubscription(string id);
        Subscription GetSubscriptionByName(string name);
        Subscription AddOrUpdateSubscription(Subscription subscription);
        void DeleteSubscription(string id);

        // Publication
        Int64 StorePayload(string payload);
        string GetPayload(Int64 id);
        int DeletePayload(Int64 id);
        Int64 AddTopicEvent(TopicEvent topicEvent);
        Int64 AddSubscriptionEvent(SubscriptionEvent subscriptionEvent);

        // Consumption
        //IEnumerable<SubscriptionEventIdentifier> FindConsumableEventsForSubscription(Subscription subscription, int maxCount);
        //bool TryLockConsumableEvent(SubscriptionEventIdentifier sId, string deliveryKey, DateTime invisibleUntilUtc);
        IEnumerable<ConsumableEvent> ConsumeNext(string subscriptionName, int visibilityTimeout, int maxCount = 1);
        void MarkConsumed(Int64 id, string deliveryKey);
        void MarkFailed(Int64 id, string deliveryKey, Reason reason);
    }
}
