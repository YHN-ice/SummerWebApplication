package demo;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

public class ReflectionUtils {

    public static void setFieldValue(Object obj,String fieldName,Object value){
        Field field=getDeclaredField(obj, fieldName);
        if(field==null){
            throw new IllegalArgumentException("Could not find field["+
                    fieldName+"] on target ["+obj+"]");
        }
        makeAccessiable(field);
        try{
            field.set(obj, value);
        }
        catch(IllegalAccessException e){
            e.printStackTrace();
        }
    }

    public static void makeAccessiable(Field field){
        if(!Modifier.isPublic(field.getModifiers())){
            field.setAccessible(true);
        }
    }

    public static Field getDeclaredField(Object obj,String fieldName){
        for (Class<?> clazz=obj.getClass(); clazz!=Object.class; clazz=clazz.getSuperclass()){
            try{
                return clazz.getDeclaredField(fieldName);
            }
            catch(Exception e){
                e.printStackTrace();
            }
        }
        return null;
    }


}
