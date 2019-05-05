package js.eventemitter2;

import haxe.Constraints.Function;
import haxe.extern.Rest;

#if nodejs
@:jsRequire("eventemitter2")
#else
@:native("EventEmitter2")
#end
extern class EventEmitter2<TSelf: EventEmitter2<TSelf>> implements IEventEmitter {
    function new();

    function addListener<T: Function>(event: Event<T>, listener: T): TSelf;
    function on<T: Function>(event: Event<T>, listener: T): TSelf;
    function once<T: Function>(event: Event<T>, listener: T): TSelf;
    function prependListener<T: Function>(event: Event<T>, listener: T): TSelf;
    function prependOnceListener<T: Function>(event: Event<T>, listener: T): TSelf;
    function removeListener<T: Function>(event: Event<T>, listener: T): TSelf;
    function removeAllListeners<T: Function>(?event: Event<T>): TSelf;
    function setMaxListeners(n: Int): Void;
    function getMaxListeners(): Int;
    function listeners<T: Function>(event: Event<T>):Array<T>;
    function emit<T: Function>(event: Event<T>, args: Rest<Dynamic>): Bool;
    function eventNames(): Array<String>;
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

@:enum abstract EventEmitterEvent<T: Function>(Event<T>) to Event<T> {
    var NewListener: EventEmitterEvent<String -> Function -> Void> = "newListener";
    var RemoveListener: EventEmitterEvent<String -> Function -> Void> = "removeListener";
}
#end
