module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-51> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-38> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<-47> : tensor<6x8xi64>}> : () -> tensor<6x8xi64>
    %3 = "tosa.const"() <{values = dense<190> : tensor<46x8xi64>}> : () -> tensor<46x8xi64>
    %ca = "tosa.const"() <{values = dense<0> : tensor<i32>}> : () -> tensor<i32>
    %cb = "tosa.const"() <{values = dense<31> : tensor<i32>}> : () -> tensor<i32>
    %cc = tosa.maximum %1, %ca : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cd = tosa.minimum %cc, %cb : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = tosa.arithmetic_right_shift %0, %cd {round = false} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %8 = tosa.bitwise_or %7, %4 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %9 = tosa.bitwise_and %8, %7 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.concat %2, %3 {axis = 0 : i32} : (tensor<6x8xi64>, tensor<46x8xi64>) -> tensor<52x8xi64>
    %cast = tensor.cast %9 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<52x8xi64> to tensor<*xi64>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI64(%cast_0) : (tensor<*xi64>) -> ()
    return
  }
}