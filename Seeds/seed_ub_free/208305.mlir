module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6> : tensor<5x3x6x5xi8>}> : () -> tensor<5x3x6x5xi8>
    %1 = "tosa.const"() <{values = dense<-1.733700e+02> : tensor<7x2x6x4xf32>}> : () -> tensor<7x2x6x4xf32>
    %2 = tosa.abs %0 : (tensor<5x3x6x5xi8>) -> tensor<5x3x6x5xi8>
    %3 = tosa.tanh %1 : (tensor<7x2x6x4xf32>) -> tensor<7x2x6x4xf32>
    %4 = tosa.bitwise_and %2, %2 : (tensor<5x3x6x5xi8>, tensor<5x3x6x5xi8>) -> tensor<5x3x6x5xi8>
    %5 = tosa.reduce_min %4 {axis = 0 : i32} : (tensor<5x3x6x5xi8>) -> tensor<1x3x6x5xi8>
    %6 = tosa.const_shape  {values = dense<[45, 1, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %7 = tosa.reshape %5, %6 : (tensor<1x3x6x5xi8>, !tosa.shape<4>) -> tensor<45x1x1x2xi8>
    %8 = tosa.minimum %7, %7 : (tensor<45x1x1x2xi8>, tensor<45x1x1x2xi8>) -> tensor<45x1x1x2xi8>
    %cast = tensor.cast %3 : tensor<7x2x6x4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<45x1x1x2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

