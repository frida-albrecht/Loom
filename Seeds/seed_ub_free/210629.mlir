module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-5.143000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<-11> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<1> : tensor<i8>}> : () -> tensor<i8>
    %3 = tosa.sigmoid %0 : (tensor<2xf32>) -> tensor<2xf32>
    %4 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.tile %3, %4 : (tensor<2xf32>, !tosa.shape<1>) -> tensor<4xf32>
    // Fix for tosa.arithmetic_right_shift:
    // The second operand (shift amount) for i8 must be within [0, 7].
    // Insert clamping operations for %2 to ensure it is within the valid range.
    %a1 = "tosa.const"() <{values = dense<0> : tensor<i8>}> : () -> tensor<i8>
    %a2 = "tosa.const"() <{values = dense<7> : tensor<i8>}> : () -> tensor<i8>
    %a3 = tosa.maximum %2, %a1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %a4 = tosa.minimum %a3, %a2 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %6 = tosa.arithmetic_right_shift %1, %a4 {round = true} : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %7 = tosa.clamp %6 {max_val = 70 : i8, min_val = -27 : i8} : (tensor<i8>) -> tensor<i8>
    %8 = tosa.bitwise_xor %7, %7 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %9 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %10 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %11 = tosa.slice %3, %9, %10 : (tensor<2xf32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<2xf32>
    %cast = tensor.cast %5 : tensor<4xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<i8> to tensor<*xi8>
    %cast_1 = tensor.cast %11 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}