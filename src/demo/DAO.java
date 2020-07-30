package demo;
import items.*;
import com.sun.deploy.util.ReflectionUtil;

import javax.swing.plaf.basic.BasicScrollPaneUI;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DAO {


    public void update(String sql, Object... args) {
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        try {
            conn = JDBCTools.getConnection();
            preparedStatement = conn.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.releaseDB(null, preparedStatement, conn);
        }
    }

    public <T> T get(Class<T> clazz, String sql, Object... args) {
        T entity = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            //1、连接数据库
            connection = JDBCTools.getConnection();
            //2、获得preparedStatement
            preparedStatement = connection.prepareStatement(sql);
            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                Map<String, Object> values = new HashMap<String, Object>();
                ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
                int columnCount = resultSetMetaData.getColumnCount();
                //得到每一列的别名 和具体的对象
                for (int i = 0; i < columnCount; i++) {
                    String columnLabel = resultSetMetaData.getColumnLabel(i + 1);
                    Object columnValue = resultSet.getObject(columnLabel);
                    //填充map对象
                    values.put(columnLabel, columnValue);
                }
                //用反射创建class对应的对象
                entity = clazz.newInstance();
                //遍历Map 对象，用反射填充对象的属性值
                for (Map.Entry<String, Object> entry : values.entrySet()) {
                    String propertyName = entry.getKey();
                    Object value = entry.getValue();

                    ReflectionUtils.setFieldValue(entity, propertyName, value);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.releaseDB(resultSet, preparedStatement, connection);
        }
        return entity;
    }

    public <T> List<T> getForList(Class<T> clazz, String sql, Object... args) {
        List<T> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try{
            conn = JDBCTools.getConnection();
            preparedStatement = conn.prepareStatement(sql);
            for(int i = 0; i < args.length; i++){
                preparedStatement.setObject(i+1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();
            List<Map<String, Object>> values = new ArrayList<>();

            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
            Map<String, Object> map = null;

            while(resultSet.next()){
                map = new HashMap<>();
                for(int i = 0; i < resultSetMetaData.getColumnCount(); i++){
                    String columnLabel = resultSetMetaData.getColumnLabel(i+1);
                    Object value = resultSet.getObject(i+1);
                    map.put(columnLabel,value);
                }

                values.add(map);
            }

            T bean = null;
            if(values.size()>0){
                for(Map<String, Object>m: values){
                    bean = clazz.newInstance();

                    for(Map.Entry<String, Object> entry: m.entrySet()){
                        String propertyName = entry.getKey();
                        Object value = entry.getValue();
                        ReflectionUtils.setFieldValue(bean,propertyName,value);
                    }
                    list.add(bean);


                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JDBCTools.releaseDB(resultSet,preparedStatement,conn);
        }
        return  list;
    }

    public <E> E getForValue(String sql, Object ... args){
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            conn = JDBCTools.getConnection();
            preparedStatement = conn.prepareStatement(sql);

            for (int i = 0; i < args.length; i++) {
                preparedStatement.setObject(i + 1, args[i]);
            }
            resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                return (E) resultSet.getObject(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.releaseDB(null, preparedStatement, conn);
        }
        return null;
    }
}
