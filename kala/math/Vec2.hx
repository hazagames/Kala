package kala.math;

import kha.FastFloat;
import kha.math.FastMatrix3;
import kha.math.Vector2;

class Vec2 {
	
	public static inline function toVector2Array(vectors:Array<Vec2>):Array<Vector2> {
		return [for (vec in vectors) new Vector2(vec.x, vec.y)];
	}
	
	public var x:Float;
	public var y:Float;
	public var length(get, set):Float;
	
	public inline function new(x:FastFloat = 0, y:FastFloat = 0): Void {
		this.x = x;
		this.y = y;
	}
	
	@:extern
	public inline function set(x:FastFloat = 0, y:FastFloat = 0):Vec2 {
		this.x = x;
		this.y = y;
		
		return this;
	}
	
	@:extern
	public inline function clone():Vec2 {
		return new Vec2(x, y);
	}
	
	@:extern
	public inline function toVector2():Vector2 {
		return new Vector2(x, y);
	}
	
	@:extern 
	public inline function add(vec:Vec2):Vec2 {
		return new Vec2(x + vec.x, y + vec.y);
	}
	
	@:extern 
	public inline function sub(vec:Vec2):Vec2 {
		return new Vec2(x - vec.x, y - vec.y);
	}
	
	@:extern 
	public inline function mult(value:FastFloat):Vec2 {
		return new Vec2(x * value, y * value);
	}
	
	@:extern 
	public inline function div(value:FastFloat):Vec2 {
		return mult(1 / value);
	}
	
	@:extern 
	public inline function addBy(vec:Vec2):Vec2 {
		x += vec.x;
		y += vec.y;
		
		return this;
	}
	
	@:extern
	public inline function invert():Vec2 {
		x = -x;
		y = -y;
		
        return this;
    }
	
	@:extern
    public inline function cross(vec:Vec2):FastFloat {
        return x * vec.y - y * vec.x;
    }
	
	@:extern 
	public inline function dot(vec:Vec2):FastFloat {
		return x * vec.x + y * vec.y;
	}
	
	@:extern
	public inline function angle(vec:Vec2):FastFloat {
		var theta1:FastFloat = Math.atan2(y, x);
		var theta2:FastFloat = Math.atan2(vec.y, vec.x);
		var dtheta = theta2 - theta1;
		
		var twoPI = Math.PI * 2;
		
		while (dtheta > Math.PI) dtheta -= twoPI;
		while (dtheta < -Math.PI) dtheta += twoPI;

		return dtheta;
	}
	
	@:extern 
	public inline function normalize():Vec2 {
		if(length == 0){
			x = 1;
			return this;
		}

		var len = length;
		x /= len;
		y /= len;
		
		return this;
	}
	
	@:extern
	public inline function truncate(max:Float):Vec2 {
		length = Math.min(max, length);
		return this;
	}
	
	@:extern
	public inline function transform(matrix:FastMatrix3):Vec2 {
        var vec = clone();
		
        vec.x = x * matrix._00 + y * matrix._10 + matrix._20;
        vec.y = x * matrix._01 + y * matrix._11 + matrix._21;
		
        return vec;
    }
	
	@:extern
	public inline function transformBy(matrix:FastMatrix3):Vec2 {
        var xx = x;
		var yy = y;
		
        x = xx * matrix._00 + yy * matrix._10 + matrix._20;
        y = xx * matrix._01 + yy * matrix._11 + matrix._21;
		
        return this;
    }
	
	function get_length():FastFloat {
		return Math.sqrt(x * x + y * y);
	}
	
	function set_length(value:FastFloat):FastFloat {
        var angle = Math.atan2(y, x);

        x = Math.cos(angle) * value;
        y = Math.sin(angle) * value;

        if (Math.abs(x) < 0.00000001) x = 0;
        if (Math.abs(y) < 0.00000001) y = 0;

		return value;
	}
	
	public inline function toString():String {
		return "Vec2(x: " + x + ", y: " + y + ")";
	}
	


	

} 
