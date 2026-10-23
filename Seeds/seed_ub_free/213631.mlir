module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<38> : tensor<i64>}> : () -> tensor<i64>
    %1 = "tosa.const"() <{values = dense<125> : tensor<i64>}> : () -> tensor<i64>
    %2 = "tosa.const"() <{values = dense<-1> : tensor<4x7xi8>}> : () -> tensor<4x7xi8>
    %3 = "tosa.const"() <{values = dense<-2.429000e+01> : tensor<f32>}> : () -> tensor<f32>
    %c63 = "tosa.const"() <{values = dense<63> : tensor<i64>}> : () -> tensor<i64>
    %s1 = tosa.minimum %1, %c63 : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %4 = tosa.arithmetic_right_shift %0, %s1 {round = true} : (tensor<i64>, tensor<i64>) -> tensor<i64>
    %5 = tosa.reduce_product %2 {axis = 1 : i32} : (tensor<4x7xi8>) -> tensor<4x1xi8>
    %6 = tosa.floor %3 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.tanh %6 : (tensor<f32>) -> tensor<f32>
    %8 = tosa.bitwise_or %5, %5 : (tensor<4x1xi8>, tensor<4x1xi8>) -> tensor<4x1xi8>
    %cast = tensor.cast %4 : tensor<i64> to tensor<*xi64>
    %cast_0 = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %8 : tensor<4x1xi8> to tensor<*xi8>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}