module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<7xi8>}> : () -> tensor<7xi8>
    %1 = "tosa.const"() <{values = dense<87> : tensor<1x2xi64>}> : () -> tensor<1x2xi64>
    %2 = "tosa.const"() <{values = dense<-1.165900e+02> : tensor<3x1x8xf32>}> : () -> tensor<3x1x8xf32>
    %3 = tosa.const_shape  {values = dense<0> : tensor<2xindex>} : () -> !tosa.shape<2>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %5 = tosa.pad %0, %3, %4 : (tensor<7xi8>, !tosa.shape<2>, tensor<1xi8>) -> tensor<7xi8>
    %6 = tosa.exp %2 : (tensor<3x1x8xf32>) -> tensor<3x1x8xf32>
    %7 = tosa.reciprocal %6 : (tensor<3x1x8xf32>) -> tensor<3x1x8xf32>
    %8 = tosa.floor %7 : (tensor<3x1x8xf32>) -> tensor<3x1x8xf32>
    %9 = tosa.const_shape  {values = dense<[12, 1, 1, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %10 = tosa.reshape %6, %9 : (tensor<3x1x8xf32>, !tosa.shape<4>) -> tensor<12x1x1x2xf32>
    %11 = tosa.bitwise_and %5, %5 : (tensor<7xi8>, tensor<7xi8>) -> tensor<7xi8>
    %12 = tosa.minimum %10, %10 : (tensor<12x1x1x2xf32>, tensor<12x1x1x2xf32>) -> tensor<12x1x1x2xf32>
    %13 = tosa.tanh %12 : (tensor<12x1x1x2xf32>) -> tensor<12x1x1x2xf32>
    %14 = tosa.pow %8, %7 : (tensor<3x1x8xf32>, tensor<3x1x8xf32>) -> tensor<3x1x8xf32>
    %15 = tosa.logical_left_shift %5, %11 : (tensor<7xi8>, tensor<7xi8>) -> tensor<7xi8>
    %cast = tensor.cast %13 : tensor<12x1x1x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %14 : tensor<3x1x8xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %15 : tensor<7xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_1) : (tensor<*xi8>) -> ()
    return
  }
}

