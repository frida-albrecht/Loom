module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<1x1x7x8xi8>}> : () -> tensor<1x1x7x8xi8>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1x1x1x1xi8>}> : () -> tensor<1x1x1x1xi8>
    %2 = "tosa.const"() <{values = dense<-1.019300e+02> : tensor<f32>}> : () -> tensor<f32>
    %3 = tosa.minimum %0, %1 : (tensor<1x1x7x8xi8>, tensor<1x1x1x1xi8>) -> tensor<1x1x7x8xi8>
    %4 = tosa.bitwise_and %3, %3 : (tensor<1x1x7x8xi8>, tensor<1x1x7x8xi8>) -> tensor<1x1x7x8xi8>
    %5 = tosa.identity %4 : (tensor<1x1x7x8xi8>) -> tensor<1x1x7x8xi8>
    %6 = tosa.tanh %2 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.clamp %6 {max_val = 4.700000e+01 : f32, min_val = 1.700000e+01 : f32} : (tensor<f32>) -> tensor<f32>
    %8 = tosa.const_shape  {values = dense<[7, 2, 2, 2]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %9 = tosa.reshape %5, %8 : (tensor<1x1x7x8xi8>, !tosa.shape<4>) -> tensor<7x2x2x2xi8>
    %10 = tosa.const_shape  {values = dense<[3, 3, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %11 = tosa.tile %9, %10 : (tensor<7x2x2x2xi8>, !tosa.shape<4>) -> tensor<21x6x2x2xi8>
    %cast = tensor.cast %7 : tensor<f32> to tensor<*xf32>
    %cast_0 = tensor.cast %11 : tensor<21x6x2x2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

