module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.181000e+01> : tensor<4x9x10x6xf32>}> : () -> tensor<4x9x10x6xf32>
    %1 = "tosa.const"() <{values = dense<-15> : tensor<6x9x9x6xi8>}> : () -> tensor<6x9x9x6xi8>
    %2 = "tosa.const"() <{values = dense<-10> : tensor<6x1x9x6xi8>}> : () -> tensor<6x1x9x6xi8>
    %3 = tosa.reciprocal %0 : (tensor<4x9x10x6xf32>) -> tensor<4x9x10x6xf32>
    %4 = tosa.reverse %3 {axis = 2 : i32} : (tensor<4x9x10x6xf32>) -> tensor<4x9x10x6xf32>
    %5 = tosa.reduce_max %4 {axis = 2 : i32} : (tensor<4x9x10x6xf32>) -> tensor<4x9x1x6xf32>
    %6 = tosa.arithmetic_right_shift %1, %2 {round = true} : (tensor<6x9x9x6xi8>, tensor<6x1x9x6xi8>) -> tensor<6x9x9x6xi8>
    %7 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<4x9x1x6xf32>) -> tensor<4x9x1x6xf32>
    %8 = tosa.tanh %7 : (tensor<4x9x1x6xf32>) -> tensor<4x9x1x6xf32>
    %9 = tosa.exp %8 : (tensor<4x9x1x6xf32>) -> tensor<4x9x1x6xf32>
    %10 = tosa.bitwise_xor %6, %6 : (tensor<6x9x9x6xi8>, tensor<6x9x9x6xi8>) -> tensor<6x9x9x6xi8>
    %11 = tosa.tanh %8 : (tensor<4x9x1x6xf32>) -> tensor<4x9x1x6xf32>
    %cast = tensor.cast %9 : tensor<4x9x1x6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %10 : tensor<6x9x9x6xi8> to tensor<*xi8>
    %cast_1 = tensor.cast %11 : tensor<4x9x1x6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

