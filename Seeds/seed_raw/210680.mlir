module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-19> : tensor<7x10x3xi8>}> : () -> tensor<7x10x3xi8>
    %1 = "tosa.const"() <{values = dense<-12> : tensor<34x10x3xi8>}> : () -> tensor<34x10x3xi8>
    %2 = "tosa.const"() <{values = dense<-1.804100e+02> : tensor<3x10x9xf32>}> : () -> tensor<3x10x9xf32>
    %3 = tosa.concat %0, %1 {axis = 0 : i32} : (tensor<7x10x3xi8>, tensor<34x10x3xi8>) -> tensor<41x10x3xi8>
    %4 = tosa.clz %3 : (tensor<41x10x3xi8>) -> tensor<41x10x3xi8>
    %5 = tosa.const_shape  {values = dense<[3, 2, 2]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.tile %4, %5 : (tensor<41x10x3xi8>, !tosa.shape<3>) -> tensor<123x20x6xi8>
    %7 = tosa.reverse %6 {axis = 0 : i32} : (tensor<123x20x6xi8>) -> tensor<123x20x6xi8>
    %8 = tosa.reduce_sum %7 {axis = 1 : i32} : (tensor<123x20x6xi8>) -> tensor<123x1x6xi8>
    %9 = tosa.arithmetic_right_shift %8, %8 {round = false} : (tensor<123x1x6xi8>, tensor<123x1x6xi8>) -> tensor<123x1x6xi8>
    %10 = tosa.tanh %2 : (tensor<3x10x9xf32>) -> tensor<3x10x9xf32>
    %11 = tosa.ceil %10 : (tensor<3x10x9xf32>) -> tensor<3x10x9xf32>
    %cast = tensor.cast %9 : tensor<123x1x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %11 : tensor<3x10x9xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

