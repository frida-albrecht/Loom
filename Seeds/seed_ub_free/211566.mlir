module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<4x3x10xi8>}> : () -> tensor<4x3x10xi8>
    %1 = "tosa.const"() <{values = dense<156> : tensor<3x2xi32>}> : () -> tensor<3x2xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi8>}> : () -> tensor<1xi8>
    %4 = tosa.pad %0, %2, %3 : (tensor<4x3x10xi8>, !tosa.shape<6>, tensor<1xi8>) -> tensor<4x3x10xi8>
    %5 = tosa.minimum %4, %4 : (tensor<4x3x10xi8>, tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %7 = tosa.maximum %6, %4 : (tensor<4x3x10xi8>, tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %8 = tosa.abs %7 : (tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    // Original %4 value is -9.
    // For tosa.logical_right_shift with i8, the shift amount must be in range [0, 7].
    // Insert operations to clamp %4 to this valid range.
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x3x10xi8>}> : () -> tensor<4x3x10xi8>
    %c7 = "tosa.const"() <{values = dense<7> : tensor<4x3x10xi8>}> : () -> tensor<4x3x10xi8>
    %l9 = tosa.maximum %4, %c0 : (tensor<4x3x10xi8>, tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %s9 = tosa.minimum %l9, %c7 : (tensor<4x3x10xi8>, tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %9 = tosa.logical_right_shift %8, %s9 : (tensor<4x3x10xi8>, tensor<4x3x10xi8>) -> tensor<4x3x10xi8>
    %cast = tensor.cast %9 : tensor<4x3x10xi8> to tensor<*xi8>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    return
  }
}