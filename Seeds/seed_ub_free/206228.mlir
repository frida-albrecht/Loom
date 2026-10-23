module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.418900e+02> : tensor<f32>}> : () -> tensor<f32>
    %1 = "tosa.const"() <{values = dense<14> : tensor<10x10x4xi8>}> : () -> tensor<10x10x4xi8>
    %2 = "tosa.const"() <{values = dense<-84> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<-104> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.reciprocal %0 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.reduce_sum %1 {axis = 2 : i32} : (tensor<10x10x4xi8>) -> tensor<10x10x1xi8>
    %6 = tosa.maximum %5, %5 : (tensor<10x10x1xi8>, tensor<10x10x1xi8>) -> tensor<10x10x1xi8>
    %7 = tosa.reduce_product %5 {axis = 0 : i32} : (tensor<10x10x1xi8>) -> tensor<1x10x1xi8>
    %8 = tosa.identity %7 : (tensor<1x10x1xi8>) -> tensor<1x10x1xi8>
    %9 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %10 = tosa.reduce_min %8 {axis = 0 : i32} : (tensor<1x10x1xi8>) -> tensor<1x10x1xi8>
    %11 = tosa.arithmetic_right_shift %9, %9 {round = true} : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<10x10x1xi8>}> : () -> tensor<10x10x1xi8>
    %t0 = tosa.maximum %6, %c0 : (tensor<10x10x1xi8>, tensor<10x10x1xi8>) -> tensor<10x10x1xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<10x10x1xi8>}> : () -> tensor<10x10x1xi8>
    %t1 = tosa.minimum %t0, %c7 : (tensor<10x10x1xi8>, tensor<10x10x1xi8>) -> tensor<10x10x1xi8>
    %12 = tosa.arithmetic_right_shift %6, %t1 {round = true} : (tensor<10x10x1xi8>, tensor<10x10x1xi8>) -> tensor<10x10x1xi8>
    %cast = tensor.cast %4 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<1x10x1xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %11 : tensor<i32> to tensor<*xi32>
    %cast_2 = tensor.cast %12 : tensor<10x10x1xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI8(%cast_2) : (tensor<*xi8>) -> ()
    return
  }
}