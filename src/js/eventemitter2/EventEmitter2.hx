package js.eventemitter2;

import js.Promise;
import haxe.Constraints.Function;
import haxe.extern.Rest;

#if nodejs
@:jsRequire("eventemitter2")
#else
@:native("EventEmitter2")
#end
extern class EventEmitter2<TSelf: EventEmitter2<TSelf>> implements IEventEmitter {
    function new(?options: EventEmitter2Options);

    /**
     * Alias of on().
     */
    function addListener<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Adds a listener to the end of the listeners array for the specified event.
     */
    function on<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Adds a one time listener for the event. The listener is invoked only the first time
     * the event is fired, after which it is removed.
     */
    function once<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Adds a listener that will be fired when any event is emitted.
     * The event name is passed as the first argument to the callback.
     */
    function onAny(listener: Function): TSelf;

    /**
     * Adds a listener to the beginning of the listeners array for the specified event.
     */
    function prependListener<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Adds a one time listener for the event. The listener is invoked only
     * the first time the event is fired, after which it is removed.
     * The listener is added to the beginning of the listeners array.
     */
    function prependOnceListener<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Adds a listener that will execute n times for the event before being removed.
     * The listener is invoked only the first n times the event is fired, after which
     * it is removed.
     */
    function many<T: Function>(event: Event<T>, timesToListen: Int, listener: T): TSelf;

    /**
     * Adds a listener that will execute n times for the event before being removed.
     * The listener is invoked only the first n times the event is fired, after which
     * it is removed. The listener is added to the beginning of the listeners array.
     */
    function prependMany<T: Function>(event: Event<T>, timesToListen: Int, listener: T): TSelf;

    /**
     * Adds a listener that will be fired when any event is emitted. The event name
     * is passed as the first argument to the callback. The listener is added to the
     * beginning of the listeners array.
     */
    function prependAny(listener: Function): TSelf;

    /**
     * Alias of off()
     */
    function removeListener<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Remove a listener from the listener array for the specified event.
     * Caution: Calling this method changes the array indices in the listener array
     * behind the listener.
     */
    function off<T: Function>(event: Event<T>, listener: T): TSelf;

    /**
     * Removes all listeners, or those of the specified event.
     */
    function removeAllListeners<T: Function>(?event: Event<T>): TSelf;

    /**
     * Removes the listener that will be fired when any event is emitted.
     */
    function offAny<T>(listener: Function): TSelf;

    /**
     * By default EventEmitters will print a warning if more than 10 listeners
     * are added to it. This is a useful default which helps finding memory leaks.
     * Obviously not all Emitters should be limited to 10.
     * This function allows that to be increased. Set to zero for unlimited.
     */
    function setMaxListeners(n: Int): Void;

    /**
     * This method is not implemented in EventEmitter2.
     */
    @:deprecated function getMaxListeners(): Int;

    /**
     * Returns an array of listeners for the specified event.
     * This array can be manipulated, e.g. to remove listeners.
     */
    function listeners<T: Function>(event: Event<T>):Array<T>;

    /**
     * Returns an array of listeners that are listening for any event that is specified.
     * This array can be manipulated, e.g. to remove listeners.
     */
    function listenersAny(): Array<Function>;

    /**
     * Execute each of the listeners that may be listening for the specified event name
     * in order with the list of arguments.
     */
    function emit<T: Function>(event: Event<T>, args: Rest<Dynamic>): Bool;

    /**
     * Return the results of the listeners via Promise.all.
     * Only this method doesn't work IE.
     */
    function emitAsync(event: String, args: Rest<Dynamic>): Promise<Array<Dynamic>>;

    /**
     * Returns an array listing the events for which the emitter has registered listeners.
     * The values in the array will be strings.
     */
    function eventNames(): Array<String>;
}

typedef EventEmitter2Options = {
    /**
     * set this to `true` to use wildcards.
     *
     * default: false
     */
    var ?wildcard: Bool;

    /**
     * the delimiter used to segment namespaces.
     *
     * default: '.'
     */
    var ?delimiter: String;

    /**
     * set this to `true` if you want to emit the newListener events.
     *
     * default: true
     */
    var ?newListener: Bool;

    /**
     * the maximum amount of listeners that can be assigned to an event.
     *
     * default: 10
     */
    var ?maxListeners: Bool;

    /**
     * show event name in memory leak message when more than maximum amountof listeners is assigned.
     *
     * default: false
     */
    var ?verboseMemoryLeak: Bool;
}

#if nodejs
typedef Event<T> = js.node.events.Event<T>;
typedef IEventEmitter = js.node.events.IEventEmitter;
typedef EventEmitterEvent = js.node.events.EventEmitterEvent;
#else
abstract Event<T: Function>(String) from String to String {}

@:remove
extern interface IEventEmitter {
    function addListener<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function on<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function once<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function prependListener<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function prependOnceListener<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function removeListener<T: Function>(event: Event<T>, listener: T): IEventEmitter;
    function removeAllListeners<T: Function>(?event: Event<T>): IEventEmitter;
    function setMaxListeners(n: Int): Void;
    function getMaxListeners(): Int;
    function listeners<T: Function>(event: Event<T>):Array<T>;
    function emit<T: Function>(event: Event<T>, args: Rest<Dynamic>): Bool;
    function eventNames(): Array<String>;
}

enum abstract EventEmitterEvent<T: Function>(Event<T>) to Event<T> {
    var NewListener: EventEmitterEvent<String -> Function -> Void> = "newListener";
    var RemoveListener: EventEmitterEvent<String -> Function -> Void> = "removeListener";
}
#end
