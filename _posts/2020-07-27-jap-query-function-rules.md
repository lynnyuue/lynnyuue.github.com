---
layout: post
title: This is a new article
category: java
tags: [jpa, spring]
author: Lynn
summary: JPA query function name rules
---

# 通过解析方法名创建查询

通过前面的例子，读者基本上对解析方法名创建查询的方式有了一个大致的了解，这也是 Spring Data JPA 吸引开发者的一个很重要的因素。该功能其实并非 Spring Data JPA 首创，而是源自一个开源的 JPA 框架 Hades，该框架的作者 Oliver Gierke 本身又是 Spring Data JPA 项目的 Leader，所以把 Hades 的优势引入到 Spring Data JPA 也就是顺理成章的了。

框架在进行方法名解析时，会先把方法名多余的前缀截取掉，比如 find、findBy、read、readBy、get、getBy，然后对剩下部分进行解析。并且如果方法的最后一个参数是 Sort 或者 Pageable 类型，也会提取相关的信息，以便按规则进行排序或者分页查询。

在创建查询时，我们通过在方法名中使用属性名称来表达，比如 **findByUserAddressZip()**。框架在解析该方法时，首先剔除 findBy，然后对剩下的属性进行解析，详细规则如下（此处假设该方法针对的域对象为 AccountInfo 类型）：

先判断 **userAddressZip** （根据 **POJO** 规范，首字母变为小写，下同）是否为 AccountInfo 的一个属性，如果是，则表示根据该属性进行查询；如果没有该属性，继续第二步；  
从右往左截取第一个大写字母开头的字符串（此处为 Zip），然后检查剩下的字符串是否为 AccountInfo 的一个属性，如果是，则表示根据该属性进行查询；如果没有该属性，则重复第二步，继续从右往左截取；最后假设 user 为 AccountInfo 的一个属性；  
接着处理剩下部分（ AddressZip ），先判断 user 所对应的类型是否有 addressZip 属性，如果有，则表示该方法最终是根据 "AccountInfo.user.addressZip" 的取值进行查询；否则继续按照步骤 2 的规则从右往左截取，最终表示根据 "AccountInfo.user.address.zip" 的值进行查询。  
可能会存在一种特殊情况，比如 AccountInfo 包含一个 user 的属性，也有一个 userAddress 属性，此时会存在混淆。读者可以明确在属性之间加上 "\_" 以显式表达意图，比如 "findByUser_AddressZip()" 或者 "findByUserAddress_Zip()"。

在查询时，通常需要同时根据多个属性进行查询，且查询的条件也格式各样（大于某个值、在某个范围等等），Spring Data JPA 为此提供了一些表达条件查询的关键字，大致如下：

- And --- 等价于 SQL 中的 and 关键字，比如 findByUsernameAndPassword(String user, Striang pwd)；
- Or --- 等价于 SQL 中的 or 关键字，比如 findByUsernameOrAddress(String user, String addr)；
- Between --- 等价于 SQL 中的 between 关键字，比如 findBySalaryBetween(int max, int min)；
- LessThan --- 等价于 SQL 中的 "<"，比如 findBySalaryLessThan(int max)；
- GreaterThan --- 等价于 SQL 中的">"，比如 findBySalaryGreaterThan(int min)；
- IsNull --- 等价于 SQL 中的 "is null"，比如 findByUsernameIsNull()；
- IsNotNull --- 等价于 SQL 中的 "is not null"，比如 findByUsernameIsNotNull()；
- NotNull --- 与 IsNotNull 等价；
- Like --- 等价于 SQL 中的 "like"，比如 findByUsernameLike(String user)；
- NotLike --- 等价于 SQL 中的 "not like"，比如 findByUsernameNotLike(String user)；
- OrderBy --- 等价于 SQL 中的 "order by"，比如 findByUsernameOrderBySalaryAsc(String user)；
- Not --- 等价于 SQL 中的 "！ ="，比如 findByUsernameNot(String user)；
- In --- 等价于 SQL 中的 "in"，比如 findByUsernameIn(Collection userList) ，方法的参数可以是 Collection 类型，也可以是数组或者不定长参数；
- NotIn --- 等价于 SQL 中的 "not in"，比如 findByUsernameNotIn(Collection userList) ，方法的参数可以是 Collection 类型，也可以是数组或者不定长参数；

## Appendix C: [Repository query keywords](https://docs.spring.io/spring-data/data-jpa/docs/current/reference/html/#repository-query-keywords)

> Supported query keywords
> The following table lists the keywords generally supported by the Spring Data repository query derivation mechanism. However, consult the store-specific documentation for the exact list of supported keywords, because some keywords listed here might not be supported in a particular store.

## Table 8. Query keywords

| Logical keyword     | Keyword expressions                      |
| ------------------- | ---------------------------------------- |
| AND                 | And                                      |
| OR                  | Or                                       |
| AFTER               | After, IsAfter                           |
| BEFORE              | Before, IsBefore                         |
| CONTAINING          | Containing, IsContaining, Contains       |
| BETWEEN             | Between, IsBetween                       |
| ENDING_WITH         | EndingWith, IsEndingWith, EndsWith       |
| EXISTS              | Exists                                   |
| FALSE               | False, IsFalse                           |
| GREATER_THAN        | GreaterThan, IsGreaterThan               |
| GREATER_THAN_EQUALS | GreaterThanEqual, IsGreaterThanEqual     |
| IN                  | In, IsIn                                 |
| IS                  | Is, Equals, (or no keyword)              |
| IS_EMPTY            | IsEmpty, Empty                           |
| IS_NOT_EMPTY        | IsNotEmpty, NotEmpty                     |
| IS_NOT_NULL         | NotNull, IsNotNull                       |
| IS_NULL             | Null, IsNull                             |
| LESS_THAN           | LessThan, IsLessThan                     |
| LESS_THAN_EQUAL     | LessThanEqual, IsLessThanEqual           |
| LIKE                | Like, IsLike                             |
| NEAR                | Near, IsNear                             |
| NOT                 | Not, IsNot                               |
| NOT_IN              | NotIn, IsNotIn                           |
| NOT_LIKE            | NotLike, IsNotLike                       |
| REGEX               | Regex, MatchesRegex, Matches             |
| STARTING_WITH       | StartingWith, IsStartingWith, StartsWith |
| TRUE                | True, IsTrue                             |
| WITHIN              | Within, IsWithin                         |

### Appendix D: [Repository query return types](https://docs.spring.io/spring-data/data-jpa/docs/current/reference/html/#repository-query-return-types)

**Supported Query Return Types**

The following table lists the return types generally supported by Spring Data repositories. However, consult the store-specific documentation for the exact list of supported return types, because some types listed here might not be supported in a particular store.

> Geospatial types (such as GeoResult, GeoResults, and GeoPage) are available only for data stores that support geospatial queries.

#### Table 9. Query return types

| Return type                                                                                                                                                                        | Description                                                                                                                                                                                                                                                       |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| void                                                                                                                                                                               | Denotes no return value.                                                                                                                                                                                                                                          |
| Primitives                                                                                                                                                                         | Java primitives.                                                                                                                                                                                                                                                  |
| Wrapper types                                                                                                                                                                      | Java wrapper types.                                                                                                                                                                                                                                               |
| T                                                                                                                                                                                  | A unique entity. Expects the query method to return one result at most. If no result is found, null is returned. More than one result triggers an **IncorrectResultSizeDataAccessException**.                                                                     |
| Iterator\<T\>                                                                                                                                                                        | An Iterator.                                                                                                                                                                                                                                                      |
| Collection\<T\>                                                                                                                                                                      | A Collection.                                                                                                                                                                                                                                                     |
| List\<T\>                                                                                                                                                                            | A List.                                                                                                                                                                                                                                                           |
| Optional\<T\>                                                                                                                                                                        | A Java 8 or Guava Optional. Expects the query method to return one result at most. If no result is found, **Optional.empty()** or **Optional.absent()** is returned. More than one result triggers an **IncorrectResultSizeDataAccessException**.                 |
| Option\<T\>                                                                                                                                                                          | Either a Scala or Vavr Option type. Semantically the same behavior as Java 8’s Optional, described earlier.                                                                                                                                                       |
| Stream\<T\>                                                                                                                                                                          | A Java 8 Stream.                                                                                                                                                                                                                                                  |
| Streamable\<T\>                                                                                                                                                                      | A convenience extension of Iterable that directy exposes methods to stream, map and filter results, concatenate them etc.                                                                                                                                         |
| Types that implement Streamable and take a Streamable constructor or factory method argument                                                                                       |
| Types that expose a constructor or **…**.**of(…)**/**…**.**valueOf(…)** factory method taking a Streamable as argument. See Returning Custom Streamable Wrapper Types for details. |
| Vavr Seq, List, Map, Set                                                                                                                                                           | Vavr collection types. See Support for Vavr Collections for details.                                                                                                                                                                                              |
| Future\<T\>                                                                                                                                                                          | A Future. Expects a method to be annotated with @Async and requires Spring’s asynchronous method execution capability to be enabled.                                                                                                                              |
| CompletableFuture\<T\>                                                                                                                                                               | A Java 8 CompletableFuture. Expects a method to be annotated with @Async and requires Spring’s asynchronous method execution capability to be enabled.                                                                                                            |
| ListenableFuture                                                                                                                                                                   | A **org.springframework.util.concurrent.ListenableFuture**. Expects a method to be annotated with **@Async** and requires Spring’s asynchronous method execution capability to be enabled.                                                                        |
| Slice                                                                                                                                                                              | A sized chunk of data with an indication of whether there is more data available. Requires a Pageable method parameter.                                                                                                                                           |
| Page\<T\>                                                                                                                                                                            | A Slice with additional information, such as the total number of results. Requires a Pageable method parameter.                                                                                                                                                   |
| GeoResult\<T\>                                                                                                                                                                       | A result entry with additional information, such as the distance to a reference location.                                                                                                                                                                         |
| GeoResults\<T\>                                                                                                                                                                      | A list of GeoResult\<T\> with additional information, such as the average distance to a reference location.                                                                                                                                                         |
| GeoPage\<T\>                                                                                                                                                                         | A Page with GeoResult\<T\>, such as the average distance to a reference location.                                                                                                                                                                                   |
| Mono\<T\>                                                                                                                                                                            | A Project Reactor Mono emitting zero or one element using reactive repositories. Expects the query method to return one result at most. If no result is found, Mono.empty() is returned. More than one result triggers an IncorrectResultSizeDataAccessException. |
| Flux\<T\>                                                                                                                                                                            | A Project Reactor Flux emitting zero, one, or many elements using reactive repositories. Queries returning Flux can emit also an infinite number of elements.                                                                                                     |
| Single\<T\>                                                                                                                                                                          | A RxJava Single emitting a single element using reactive repositories. Expects the query method to return one result at most. If no result is found, Mono.empty() is returned. More than one result triggers an IncorrectResultSizeDataAccessException.           |
| Maybe\<T\>                                                                                                                                                                           | A RxJava Maybe emitting zero or one element using reactive repositories. Expects the query method to return one result at most. If no result is found, Mono.empty() is returned. More than one result triggers an IncorrectResultSizeDataAccessException.         |
| Flowable\<T\>                                                                                                                                                                        | A RxJava Flowable emitting zero, one, or many elements using reactive repositories. Queries returning Flowable can emit also an infinite number of elements.                                                                                                      |
