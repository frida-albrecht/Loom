module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9> : tensor<7x7x9xi8>}> : () -> tensor<7x7x9xi8>
    %1 = "tosa.const"() <{values = dense<17> : tensor<1x7x1xi8>}> : () -> tensor<1x7x1xi8>
    %2 = tosa.add %0, %1 : (tensor<7x7x9xi8>, tensor<1x7x1xi8>) -> tensor<7x7x9xi8>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<7x7x9xi8>}> : () -> tensor<7x7x9xi8>
    %c1 = "tosa.const"() <{values = dense<7> : tensor<7x7x9xi8>}> : () -> tensor<7x7x9xi8>
    %a0 = tosa.maximum %2, %c0 : (tensor<7x7x9xi8>, tensor<7x7x9xi8>) -> tensor<7x7x9xi8>
    %a1 = tosa.minimum %a0, %c1 : (tensor<7x7x9xi8>, tensor<7x7x9xi8>) -> tensor<7x7x9xi8>
    %3 = tosa.arithmetic_right_shift %2, %a1 {round = true} : (tensor<7x7x9xi8>, tensor<7x7x9xi8>) -> tensor<7x7x9xi8>
    %4 = tosa.abs %3 : (tensor<7x7x9xi8>) -> tensor<7x7x9xi8>
    %5 = tosa.const_shape  {values = dense<[4, 3, 0]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %6 = tosa.const_shape  {values = dense<[3, 1, 9]> : tensor<3xindex>} : () -> !tosa.shape<3>
    %7 = tosa.slice %4, %5, %6 : (tensor<7x7x9xi8>, !tosa.shape<3>, !tosa.shape<3>) -> tensor<3x1x9xi8>
    %8 = tosa.clamp %7 {max_val = 80 : i8, min_val = 17 : i8} : (tensor<3x1x9xi8>) -> tensor<3x1x9xi8>
    %9 = tosa.abs %8 : (tensor<3x1x9xi8>) -> tensor<3x1x9xi8>
    %10 = tosa.reduce_min %9 {axis = 2 : i32} : (tensor<3x1x9xi8>) -> tensor<3x1x1xi8>
    %11 = tosa.add %10, %10 : (tensor<3x1x1xi8>, tensor<3x1x1xi8>) -> tensor<3x1x1xi8>
    %12 = tosa.bitwise_or %11, %11 : (tensor<3x1x1xi8>, tensor<3x1x1xi8>) -> tensor<3x1x1xi8>
    %cast = tensor.cast %12 : tensor<3x1x1xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}