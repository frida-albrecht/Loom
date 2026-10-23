module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<1x8x7xi8>}> : () -> tensor<1x8x7xi8>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x1x1xi8>}> : () -> tensor<1x1x1xi8>
    %2 = "tosa.const"() <{values = dense<true> : tensor<8x8xi1>}> : () -> tensor<8x8xi1>
    %3 = "tosa.const"() <{values = dense<3.511000e+01> : tensor<f32>}> : () -> tensor<f32>
    %4 = tosa.sub %0, %1 : (tensor<1x8x7xi8>, tensor<1x1x1xi8>) -> tensor<1x8x7xi8>
    %5 = tosa.arithmetic_right_shift %4, %4 {round = true} : (tensor<1x8x7xi8>, tensor<1x8x7xi8>) -> tensor<1x8x7xi8>
    %6 = tosa.add %5, %5 : (tensor<1x8x7xi8>, tensor<1x8x7xi8>) -> tensor<1x8x7xi8>
    %7 = tosa.abs %6 : (tensor<1x8x7xi8>) -> tensor<1x8x7xi8>
    %8 = tosa.clz %7 : (tensor<1x8x7xi8>) -> tensor<1x8x7xi8>
    %9 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %10 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %11 = tosa.negate %8, %9, %10 : (tensor<1x8x7xi8>, tensor<1xi8>, tensor<1xi8>) -> tensor<1x8x7xi8>
    %12 = tosa.reduce_all %2 {axis = 1 : i32} : (tensor<8x8xi1>) -> tensor<8x1xi1>
    %13 = tosa.logical_and %12, %12 : (tensor<8x1xi1>, tensor<8x1xi1>) -> tensor<8x1xi1>
    %14 = tosa.reciprocal %3 : (tensor<f32>) -> tensor<f32>
    %15 = tosa.reciprocal %14 : (tensor<f32>) -> tensor<f32>
    %16 = tosa.bitwise_not %12 : (tensor<8x1xi1>) -> tensor<8x1xi1>
    %17 = tosa.argmax %12 {axis = 1 : i32} : (tensor<8x1xi1>) -> tensor<8xi32>
    %18 = tosa.bitwise_or %16, %13 : (tensor<8x1xi1>, tensor<8x1xi1>) -> tensor<8x1xi1>
    %19 = tosa.argmax %18 {axis = 0 : i32} : (tensor<8x1xi1>) -> tensor<1xi32>
    %20 = tosa.reduce_sum %19 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %11 : tensor<1x8x7xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %15 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %17 : tensor<8xi32> to tensor<*xi32>
    %cast_2 = tensor.cast %20 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_2) : (tensor<*xi32>) -> ()
    return
  }
}

