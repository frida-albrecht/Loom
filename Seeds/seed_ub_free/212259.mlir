module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<5> : tensor<8x4x8xi8>}> : () -> tensor<8x4x8xi8>
    %1 = "tosa.const"() <{values = dense<20> : tensor<32x4x8xi8>}> : () -> tensor<32x4x8xi8>
    %2 = "tosa.const"() <{values = dense<-1.826600e+02> : tensor<6x8x4xf32>}> : () -> tensor<6x8x4xf32>
    %3 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<8x4x8xi8>, tensor<32x4x8xi8>) -> tensor<40x4x8xi8>
    %4 = tosa.clamp %3 {max_val = 59 : i8, min_val = 57 : i8} : (tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %5 = tosa.tanh %2 : (tensor<6x8x4xf32>) -> tensor<6x8x4xf32>
    %6 = tosa.tanh %5 : (tensor<6x8x4xf32>) -> tensor<6x8x4xf32>
    %7 = tosa.logical_left_shift %3, %3 : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %8 = tosa.reduce_sum %5 {axis = 2 : i32} : (tensor<6x8x4xf32>) -> tensor<6x8x1xf32>
    %9 = tosa.reciprocal %6 : (tensor<6x8x4xf32>) -> tensor<6x8x4xf32>
    %10 = tosa.abs %8 : (tensor<6x8x1xf32>) -> tensor<6x8x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<40x4x8xi8>}> : () -> tensor<40x4x8xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<40x4x8xi8>}> : () -> tensor<40x4x8xi8>
    %a0 = tosa.maximum %7, %c0 : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %a1 = tosa.minimum %a0, %c7 : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %11 = tosa.arithmetic_right_shift %3, %a1 {round = true} : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %12 = tosa.logical_right_shift %4, %11 : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %13 = tosa.floor %10 : (tensor<6x8x1xf32>) -> tensor<6x8x1xf32>
    %14 = tosa.maximum %9, %6 : (tensor<6x8x4xf32>, tensor<6x8x4xf32>) -> tensor<6x8x4xf32>
    %15 = tosa.bitwise_or %11, %11 : (tensor<40x4x8xi8>, tensor<40x4x8xi8>) -> tensor<40x4x8xi8>
    %cast = tensor.cast %12 : tensor<40x4x8xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %13 : tensor<6x8x1xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %14 : tensor<6x8x4xf32> to tensor<*xf32>
    %cast_2 = tensor.cast %15 : tensor<40x4x8xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_2) : (tensor<*xi8>) -> ()
    return
  }
}