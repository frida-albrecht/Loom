module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-11> : tensor<8x9x9xi8>}> : () -> tensor<8x9x9xi8>
    %1 = "tosa.const"() <{values = dense<1.126800e+02> : tensor<9xf32>}> : () -> tensor<9xf32>
    %2 = tosa.identity %0 : (tensor<8x9x9xi8>) -> tensor<8x9x9xi8>
    %3 = tosa.sigmoid %1 : (tensor<9xf32>) -> tensor<9xf32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<9xf32>) -> tensor<i32>
    %5 = tosa.log %3 : (tensor<9xf32>) -> tensor<9xf32>
    %6 = tosa.tanh %5 : (tensor<9xf32>) -> tensor<9xf32>
    %7 = tosa.const_shape  {values = dense<[6, 3, 3, 12]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %8 = tosa.reshape %2, %7 : (tensor<8x9x9xi8>, !tosa.shape<4>) -> tensor<6x3x3x12xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<6x3x3x12xi8>}> : () -> tensor<6x3x3x12xi8>
    %t0 = tosa.maximum %8, %c0 : (tensor<6x3x3x12xi8>, tensor<6x3x3x12xi8>) -> tensor<6x3x3x12xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<6x3x3x12xi8>}> : () -> tensor<6x3x3x12xi8>
    %t1 = tosa.minimum %t0, %c1 : (tensor<6x3x3x12xi8>, tensor<6x3x3x12xi8>) -> tensor<6x3x3x12xi8>
    %9 = tosa.logical_left_shift %8, %t1 : (tensor<6x3x3x12xi8>, tensor<6x3x3x12xi8>) -> tensor<6x3x3x12xi8>
    %10 = tosa.reduce_min %9 {axis = 3 : i32} : (tensor<6x3x3x12xi8>) -> tensor<6x3x3x1xi8>
    %11 = tosa.clz %10 : (tensor<6x3x3x1xi8>) -> tensor<6x3x3x1xi8>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<9xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %11 : tensor<6x3x3x1xi8> to tensor<*xi8>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}